-- 1. Distribution of the Age group
SELECT age_group, COUNT(*) AS respondents
FROM hearing_survey
GROUP BY age_group
ORDER BY respondents DESC;

-- 2. Identify the most requested features in the app
SELECT feature, COUNT(*) AS frequency
FROM desired_features_clean
GROUP BY feature
ORDER BY frequency DESC;

-- 3. Address respondents with psychological barriers like fear and shame
SELECT category, COUNT(*) AS count
FROM hearing_test_barrier_categorized
WHERE category = 'Psychological'
GROUP BY category;

-- 4. Introduce affordable testing options (financial barriers)
SELECT category, COUNT(*) AS count
FROM hearing_test_barrier_categorized
WHERE category = 'Financial'
GROUP BY category;

-- 5. Promote awareness and education campaigns
SELECT category, COUNT(*) AS count
FROM hearing_test_barrier_categorized
WHERE category = 'Awareness'
GROUP BY category;

-- 6. Focus on independence and social connectivity for messaging
SELECT category, COUNT(*) AS count
FROM hearing_meaning_normalized
WHERE category IN ('Independence / Alertness', 'Social Connectivity')
GROUP BY category;

-- 7. Design reminders for regular testing
SELECT feature, COUNT(*) AS frequency
FROM desired_features_clean
WHERE feature = 'Regular testing reminders'
GROUP BY feature;

-- 8. Segment marketing by current hearing care beliefs
SELECT belief_early_hearing_care, COUNT(*) AS count
FROM hearing_survey
GROUP BY belief_early_hearing_care
ORDER BY belief_early_hearing_care;

-- 9. Support both family and personal use (daily headphone use)
SELECT daily_headphone_use, COUNT(*) AS count
FROM hearing_survey
GROUP BY daily_headphone_use
ORDER BY count DESC;

-- 10. Provide multiple testing options for inclusivity
SELECT last_hearing_test_method, COUNT(*) AS count
FROM hearing_survey
GROUP BY last_hearing_test_method
ORDER BY count DESC;
