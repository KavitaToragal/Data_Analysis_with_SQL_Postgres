-- 1. Age Distribution
SELECT age_group, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY age_group
ORDER BY respondents DESC;

-- 2. Belief in Early Hearing Care
SELECT belief_early_hearing_care, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY belief_early_hearing_care
ORDER BY belief_early_hearing_care;

-- 3. Daily Headphone Use
SELECT daily_headphone_use, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY daily_headphone_use
ORDER BY respondents DESC;

-- 4. Missed Important Sounds
SELECT missed_important_sounds, COUNT(*) AS frequency
FROM hearing_survey
GROUP BY missed_important_sounds
ORDER BY frequency DESC;

-- 5. Feeling Left Out Due to Hearing
SELECT left_out_due_to_hearing, COUNT(*) AS frequency
FROM hearing_survey
GROUP BY left_out_due_to_hearing
ORDER BY frequency DESC;

-- 6. Barriers to Hearing Tests (using normalized table)
SELECT category, COUNT(*) AS barrier_count
FROM hearing_test_barrier_categorized
GROUP BY category
ORDER BY barrier_count DESC;

-- 7. Methods of Last Hearing Test
SELECT last_hearing_test_method, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY last_hearing_test_method
ORDER BY respondents DESC;

-- 8. Interest in Hearing App
SELECT interest_in_hearing_app, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY interest_in_hearing_app
ORDER BY respondents DESC;

-- 9. Desired App Features (using normalized table)
SELECT feature, COUNT(*) AS frequency
FROM desired_features_clean
GROUP BY feature
ORDER BY frequency DESC;

-- 10. Ear Discomfort After Headphone Use
SELECT ear_discomfort_after_use, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY ear_discomfort_after_use
ORDER BY respondents DESC;
