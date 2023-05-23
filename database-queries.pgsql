-- Query 1: Simple show users, to test everything work

SELECT *
FROM "User";

-- Query 2: Which user has done an exercise most often?
-- Connect User -> Workout -> Workout_exercise -> Set -> Set_history --

SELECT "User".user_id, Workout_exercise.exercise_id COUNT() AS amount
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id
JOIN Workout_exercise ON Workout.workout_id = Workout_exercise.workout_id
JOIN Set ON Workout_exercise.workout_exercise_id = Set.workout_exercise_id
JOIN Set_history ON Set.set_id = Set_history.set_id
GROUP BY 

-- Query 3: Which exercise was done the most and how often?
-- Connect 

SELECT
FROM
JOIN X ON X = X
JOIN X ON X = X
JOIN X ON X = X

-- Query 4: Delete a user that has a workout and show that this throws a referential integrity error

SELECT "User".user_id, Workout.workout_name
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id

DELETE FROM "User" 
WHERE user_id = 2

-- Error message: Aktualisieren oder Löschen in Tabelle »User« verletzt Fremdschlüssel-Constraint »fk_user_id« von Tabelle »workout«
-- DETAIL:  Auf Schlüssel (user_id)=(2) wird noch aus Tabelle »workout« verwiesen.
-- SQL state: 23503

-- Step 1--
UPDATE Workout
SET user_id = 3
WHERE user_id = 2

SELECT "User".user_id, Workout.workout_name
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id

DELETE FROM "User" 
WHERE user_id = 2

-- Error message: Aktualisieren oder Löschen in Tabelle »User« verletzt Fremdschlüssel-Constraint »fk_user_id« von Tabelle »exercise«
-- DETAIL:  Auf Schlüssel (user_id)=(2) wird noch aus Tabelle »exercise« verwiesen.
-- SQL state: 23503

-- Step 2--
UPDATE exercise
SET user_id = 3
WHERE user_id = 2

SELECT "User".user_id, Workout.workout_name
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id

DELETE FROM "User" 
WHERE user_id = 2

-- Query 5: NULL VALUE aus primary Key

SELECT *
FROM Personal_Trainer

UPDATE Personal_Trainer
SET phone = NULL
WHERE last_name = 'Brachiales' and first_name = 'Maximus'

-- Error message: NULL-Wert in Spalte »phone« von Relation »personal_trainer« verletzt Not-Null-Constraint
-- DETAIL:  Fehlgeschlagene Zeile enthält (null, Brachiales, Maximus).
-- SQL state: 23502

-- Query 6:

-- Query 7: 

-- Query 8: