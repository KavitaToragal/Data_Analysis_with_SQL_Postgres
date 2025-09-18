-- 1. Create Database (Run in PostgreSQL)
-- CREATE DATABASE hearing_wellness_db;

-- 2. Create Table
CREATE TABLE hearing_survey (
    perceived_hearing_meaning TEXT,
    hearing_fomo TEXT,
    hearing_test_barrier TEXT,
    missed_important_sounds TEXT,
    left_out_due_to_hearing TEXT,
    daily_headphone_use TEXT,
    belief_early_hearing_care INT,
    last_hearing_test_method TEXT,
    interest_in_hearing_app TEXT,
    desired_app_features TEXT,
    awareness_on_hearing_and_willingness_to_invest TEXT,
    paid_app_test_interest TEXT,
    age_group TEXT,
    ear_discomfort_after_use TEXT
);

-- 3. Add Primary Key
ALTER TABLE hearing_survey ADD COLUMN id SERIAL PRIMARY KEY;

-- 4. Standardize Text Columns (special characters + non-ASCII)
DO $$
DECLARE
    col RECORD;
BEGIN
    FOR col IN 
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'hearing_survey'
          AND data_type LIKE '%text%'
    LOOP
        EXECUTE format(
            'UPDATE hearing_survey
             SET %I = TRANSLATE(%I, ''’“”–—…'', ''''""--...'')
             WHERE %I IS NOT NULL;',
             col.column_name, col.column_name, col.column_name
        );
        EXECUTE format(
            'UPDATE hearing_survey
             SET %I = regexp_replace(%I, ''[^\x20-\x7E]'', '''', ''g'')
             WHERE %I IS NOT NULL;',
             col.column_name, col.column_name, col.column_name
        );
    END LOOP;
END $$;

-- 5. Remove Duplicates (optional if duplicates exist)
-- CREATE TABLE hearing_survey_dedup AS
-- SELECT DISTINCT * FROM hearing_survey;

-- 6. Standardize daily_headphone_use column
UPDATE hearing_survey
SET daily_headphone_use = CASE
    WHEN daily_headphone_use ILIKE '%Less than 1%' THEN '0-1 hours'
    WHEN daily_headphone_use ILIKE '%1-2%' THEN '1-2 hours'
    WHEN daily_headphone_use ILIKE '%2-4%' THEN '2-4 hours'
    WHEN daily_headphone_use ILIKE '%more than 4%' THEN '4+ hours'
    WHEN daily_headphone_use ILIKE '%my parent%' THEN 'Family use - parent'
    WHEN daily_headphone_use ILIKE '%my child%' THEN 'Family use - child'
    ELSE daily_headphone_use
END;

-- 7. Standardize interest_in_hearing_app
UPDATE hearing_survey
SET interest_in_hearing_app = CASE
    WHEN interest_in_hearing_app ILIKE 'Yes%' THEN 'Yes'
    WHEN interest_in_hearing_app ILIKE 'No%' THEN 'No'
    WHEN interest_in_hearing_app ILIKE 'Maybe%' THEN 'Maybe'
    ELSE interest_in_hearing_app
END;

-- 8. Correct typos in missed_important_sounds
UPDATE hearing_survey
SET missed_important_sounds = 'I cannot hear clearly when told important information in serious situations'
WHERE missed_important_sounds ILIKE 'I can''t hear claerly when tell important information in serious situation';

UPDATE hearing_survey
SET missed_important_sounds = 'I miss things when with friends'
WHERE missed_important_sounds ILIKE 'When with friends anol';

-- 9. Normalize hearing_test_barrier
CREATE TABLE hearing_test_barrier_normalized AS
SELECT 
    id,
    TRIM(unnest(string_to_array(hearing_test_barrier, ','))) AS barrier
FROM hearing_survey;

CREATE TABLE barrier_map (
    raw_text TEXT,
    category TEXT
);

INSERT INTO barrier_map (raw_text, category) VALUES
('Cost', 'Financial'),
('Facilities', 'Access / Infrastructure'),
('Lack of awareness', 'Awareness'),
('Fear', 'Psychological'),
('Shame', 'Psychological'),
('Time', 'Time Constraints'),
('Didn''t feel the need', 'Undecided'),
('Never', 'Undecided'),
('NA', 'Other / Unknown'),
('Not applicable', 'Other / Unknown');

CREATE TABLE hearing_test_barrier_categorized AS
SELECT 
    n.id,
    n.barrier,
    COALESCE(m.category, 'Other / Unknown') AS category
FROM hearing_test_barrier_normalized n
LEFT JOIN barrier_map m
  ON n.barrier ILIKE '%' || m.raw_text || '%';

-- 10. Normalize desired_app_features
CREATE TABLE hearing_features_normalized AS
SELECT id, feature
FROM (
    SELECT id, TRIM(unnest(string_to_array(desired_app_features, ','))) AS feature
    FROM hearing_survey
) t
WHERE feature <> '';

CREATE TABLE desired_features_clean AS
SELECT id,
       CASE 
           WHEN feature IN (
               'Quick tests',
               'Doctor consultation',
               'Game-based interaction',
               'Earphone calibration',
               'Soft guidance',
               'Regular testing reminders',
               'Detailed report generation',
               'Personalized volume adjustments',
               'Audio amplifier or sound booster',
               'Report sharing options',
               'Privacy'
           ) THEN feature
           ELSE 'Other / Misc'
       END AS feature
FROM hearing_features_normalized;

-- Remaining columns are clean or already standardized (age_group, belief_early_hearing_care, etc.)
