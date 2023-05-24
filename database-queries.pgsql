-- Query 1: Simple show users, to test everything work

SELECT *
FROM "User";

-- Query 2: Which user has done an exercise most often?

-- Show Entries in Exercise 
SELECT *
FROM Exercise;

-- Real Code
SELECT u.user_id, u.user_name, COUNT(*) AS exercise_count
FROM "User" u
JOIN Exercise e ON u.user_id = e.user_id
GROUP BY u.user_id, u.user_name
ORDER BY exercise_count DESC
LIMIT 1;

-- Query 3: Which exercise was done the most and how often?

-- Show Entries in Set_History
SELECT * 
FROM Set_history;

-- Real Code
SELECT e.exercise_name, COUNT(*) AS exercise_count
FROM Exercise e
JOIN Workout_exercise we ON e.exercise_id = we.exercise_id
JOIN Set s ON we.workout_exercise_id = s.workout_exercise_id
JOIN Set_history sh ON s.set_id = sh.set_id
GROUP BY e.exercise_name
ORDER BY exercise_count DESC
LIMIT 1;

-- Query 4: Delete a user that has a workout and show that this throws a referential integrity error

SELECT "User".user_id, Workout.workout_name
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id;

DELETE FROM "User" 
WHERE user_id = 2;

-- Error message: Aktualisieren oder Löschen in Tabelle »User« verletzt Fremdschlüssel-Constraint »fk_user_id« von Tabelle »workout«
-- DETAIL:  Auf Schlüssel (user_id)=(2) wird noch aus Tabelle »workout« verwiesen.
-- SQL state: 23503

-- Step 1--
UPDATE Workout
SET user_id = 3
WHERE user_id = 2;

SELECT "User".user_id, Workout.workout_name
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id;

DELETE FROM "User" 
WHERE user_id = 2;

-- Error message: Aktualisieren oder Löschen in Tabelle »User« verletzt Fremdschlüssel-Constraint »fk_user_id« von Tabelle »exercise«
-- DETAIL:  Auf Schlüssel (user_id)=(2) wird noch aus Tabelle »exercise« verwiesen.
-- SQL state: 23503

-- Step 2--
UPDATE exercise
SET user_id = 3
WHERE user_id = 2;

DELETE FROM "User" 
WHERE user_id = 2;

SELECT *
FROM "User"

-- Query 5: NULL VALUE aus primary Key

SELECT *
FROM Personal_Trainer;

UPDATE Personal_Trainer
SET phone = NULL
WHERE first_name = 'Maximus' and last_name = 'Brachiales';

-- Error message: NULL-Wert in Spalte »phone« von Relation »personal_trainer« verletzt Not-Null-Constraint
-- DETAIL:  Fehlgeschlagene Zeile enthält (null, Brachiales, Maximus).
-- SQL state: 23502

-- Query 6: Showing all workouts that take place at the gym with plz 76227 and have at least one exercise with muscle group that starts with "Musculus"

SELECT Workout.workout_name, Gym_Plz_City.plz, Gym_Plz_City.city
FROM Workout
JOIN Gym_Workout ON Workout.workout_id = Gym_Workout.workout_id
JOIN Gym_Plz_City ON Gym_Workout.plz = Gym_Plz_City.plz
JOIN Workout_exercise ON Workout.workout_id = Workout_exercise.workout_id
JOIN Exercise ON Workout_exercise.exercise_id = Exercise.exercise_id
JOIN Muscle ON Exercise.exercise_id = Muscle.exercise_id
WHERE Gym_Plz_City.plz = 76227 AND Muscle.muscle LIKE 'Musculus%';

-- Query 7: Find all users who have created at least three different workouts

SELECT *
FROM Workout;

SELECT "User".user_id, "User".user_name, COUNT(DISTINCT Workout.workout_id) AS workout_count
FROM "User"
JOIN Workout ON "User".user_id = Workout.user_id
GROUP BY "User".user_id, "User".user_name
HAVING COUNT(DISTINCT Workout.workout_id) >= 3;
