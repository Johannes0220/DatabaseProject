-- Create

CREATE TABLE "User" (
    user_id SERIAL NOT NULL PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
	darkmode boolean,
	gender VARCHAR(255),
    height float,
	weight float,
    age integer
);

CREATE TABLE Workout (
    workout_id SERIAL NOT NULL PRIMARY KEY,
    workout_name VARCHAR(255),
	user_id integer,
	constraint fk_user_id
    	foreign key (user_id) 
    	REFERENCES "User"(user_id)
);

CREATE TABLE Gym_Plz_City (
    plz integer NOT NULL PRIMARY KEY,
    city VARCHAR(255)
);

CREATE TABLE Gym_Workout (
    workout_id integer NOT NULL PRIMARY KEY REFERENCES Workout(workout_id),
	plz integer,
	constraint fk_plz
    	foreign key (plz) 
    	REFERENCES Gym_Plz_City(plz),
    street VARCHAR(255)
);

CREATE TABLE Calisthenics_Workout (
    workout_id integer NOT NULL PRIMARY KEY REFERENCES Workout(workout_id),
    workout_type VARCHAR(255)
);

CREATE TABLE Personal_Trainer (
    phone bigint NOT NULL PRIMARY KEY,
    last_name VARCHAR(255),
    first_name VARCHAR(255)
);

CREATE TABLE Home_Workout (
    workout_id integer NOT NULL PRIMARY KEY REFERENCES Workout(workout_id),
	phone bigint,
	constraint fk_phone
    	foreign key (phone) 
    	REFERENCES Personal_Trainer(phone)
);

CREATE TABLE Exercise (
    exercise_id SERIAL NOT NULL PRIMARY KEY,
    exercise_name VARCHAR(255) unique,
    description VARCHAR(255) NOT NULL,
    equipment VARCHAR(255),
	user_id integer,
	constraint fk_user_id
    	foreign key (user_id) 
    	REFERENCES "User"(user_id)
);

CREATE TABLE Cardio_exercise (
	exercise_id integer NOT NULL PRIMARY KEY REFERENCES Exercise(exercise_id),
    intensity integer
);

CREATE TABLE Strength_exercise (
    exercise_id integer NOT NULL PRIMARY KEY REFERENCES Exercise(exercise_id)
);

CREATE TABLE Muscle (
    muscle VARCHAR(255) NOT NULL PRIMARY KEY,
	exercise_id integer,
	constraint fk_exercise_id
    	foreign key (exercise_id) 
    	REFERENCES Strength_exercise(exercise_id)
);

CREATE TABLE Workout_exercise (
    workout_exercise_id SERIAL NOT NULL PRIMARY KEY,
	workout_id integer,
	constraint fk_workout_id
    	foreign key (workout_id) 
    	REFERENCES Workout(workout_id),
	exercise_id integer,
	constraint fk_exercise_id
    	foreign key (exercise_id) 
    	REFERENCES Strength_exercise(exercise_id),
	exercise_pause integer
);

CREATE TABLE Set (
    set_id SERIAL NOT NULL PRIMARY KEY,
	weight float NOT NULL,
	pause integer,
	reps integer NOT NULL,
	workout_exercise_id integer,
	constraint fk_workout_exercise_id
    	foreign key (workout_exercise_id) 
    	REFERENCES Workout_exercise(workout_exercise_id)
);

CREATE TABLE Set_history (
    record_time TIMESTAMP NOT NULL PRIMARY KEY,
	set_id integer,
	constraint fk_set_id
    	foreign key (set_id) 
    	REFERENCES Set(set_id),
	weight float,
    reps integer
);

-- Insert

insert into "User" (user_name, darkmode, gender, height, weight, age)
	values
		('username1', 'true', 'man', 190, 90, 20),
		('username2', 'false', 'woman', 180, 80, 22),
		('username3', 'true', 'fox', 170, 50, 23),
		('username4', 'true', 'diverse', 220, 50, 60),
		('username5', 'false', 'woman', 180, 90, 22);

insert into Workout (workout_name, user_id)
	values
		('workoutname1', 2),
		('workoutname2', 3),
		('workoutname3', 1),
		('workoutname4', 1),
		('workoutname5', 2),
		('workoutname6', 3),
		('workoutname7', 5),
		('workoutname8', 3),
		('workoutname9', 5);

insert into Gym_Plz_City (plz, city)
	values
		(76227, 'Karlsruhe'),
		(80331, 'Munich'),
		(20095, 'Hamburg'),
		(79595, 'Lörrach'),
		(77652, 'Offenburg'),
		(79098, 'Freiburg'),
		(52062, 'Aachen'),
		(10119, 'Berlin'),
		(01067, 'Dresden'),
		(76133, 'Karlsruhe');

insert into Gym_Workout (workout_id, plz, street)
	values
		(1, 76227, 'Street 1'),
		(2, 80331, 'Street 2'),
		(3, 20095, 'Street 4'),
		(5, 79595, 'Street 5'),
		(6, 77652, 'Street 6'),
		(8, 79098, 'Street 8'),
		(9, 52062, 'Street 9'),
		(4, 10119, 'Street 3');

insert into Calisthenics_Workout (workout_id, workout_type)
	values
		(1, 'Calysthenics Skill workout'),
		(2, 'calisthenics strength workout'),
		(3, 'Calysthenics Skill workout'),
		(5, 'Calysthenics Woman workout'),
		(6, 'calisthenics strength workout'),
		(8, 'Calysthenics Skill workout'),
		(9, 'calisthenics strength workout'),
		(4, 'calisthenics strength workout');

insert into Personal_Trainer (phone, last_name, first_name)
	values
		(0049123456789, 'Mustermann', 'Max'),
		(0049135446639, 'Günni', 'Nick'),
		(0049136435735, 'Bäm', 'Thomas'),
		(0049145277529, 'Schmälzen', 'Johannes'),
		(0049197546735, 'Mertel', 'Angelo'),
		(0049546265234, 'Gaski', 'Niko'),
		(0049132453464, 'Unbekannt', 'Willi'),
		(0049146243464, 'Brachiales', 'Maximus'),
		(0049143163469, 'Höpfen', 'Jörg'),
		(0049135143534, 'Held', 'Gerhard'),
		(0049157543263, 'WerBistDu', 'Peter');

insert into Home_Workout (workout_id, phone)
	values
		(1, 0049123456789),
		(2, 0049135446639),
		(3, 0049136435735),
		(4, 0049145277529),
		(5, 0049197546735),
		(6, 0049546265234),
		(7, 0049132453464),
		(8, 0049146243464),
		(9, 0049157543263);

insert into Exercise (exercise_name, description, equipment, user_id)
	values
		('exercisename1', 'description exercise 1', 'equiment1', 5),
		('exercisename2', 'description exercise 2', 'equiment2', 4),
		('exercisename3', 'description exercise 3', 'equiment3', 3),
		('exercisename4', 'description exercise 4', 'equiment4', 2),
		('exercisename5', 'description exercise 5', 'equiment5', 2),
		('exercisename6', 'description exercise 6', 'equiment6', 1),
		('exercisename7', 'description exercise 7', 'equiment7', 1),
		('exercisename8', 'description exercise 8', 'equiment8', 1),
		('exercisename9', 'description exercise 9', 'equiment9', 1);

insert into Cardio_exercise (exercise_id, intensity)
	values
		(1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 5),
		(6, 6),
		(7, 7),
		(8, 8),
		(9, 9);

insert into Strength_exercise (exercise_id)
	values
		(1),
		(2),
		(3),
		(4),
		(5),
		(6),
		(7),
		(8),
		(9);

insert into Muscle (muscle, exercise_id)
	values
		('Musculus deltoideus', 1),
		('Musculus infraspinatus', 2),
		('Musculus pectoralis major', 3),
		('Musculus latissimus dorsi', 4),
		('Musculus iliopsoas', 5),
		('Musculus tensor fasciae latae', 6),
		('Musculus rectus femoris', 7),
		('Musculus sartorius', 8),
		('Musculus popliteus', 9),
		('Musculus tibialis anterior', 1);

insert into Workout_exercise (workout_id, exercise_id, exercise_pause )
	values
		(1, 1,'20'),
		(1, 2,'30'),
		(1, 3,'40'),
		(1, 4,'50'),
		(1, 5,'60'),
		(1, 6,'20'),
		(2, 7,'30'),
		(2, 8,'40'),
		(2, 9,'50'),
		(2, 9,'60'),
		(2, 4,'20'),
		(2, 6,'30'),
		(2, 1,'40');

insert into Set (workout_exercise_id, reps, pause, weight )
	values
		(1,'1','30',20),
		(2,'1','40',20),
		(3,'2','40',20),
		(4,'2','30',20),
		(5,'3','30',20),
		(6,'4','20',20),
		(7,'5','30',20);

insert into Set_history (set_id, reps, weight, record_time)
	values
		('1','12','30','2023-04-07 16:45:25.091'),
		('1','10','40','2023-05-07 16:45:25.091'),
		('1','8', '40','2023-06-07 16:45:25.091'),
		('2','12','40','2023-07-07 16:45:25.091'),
		('2','8', '50','2023-08-07 16:45:25.091'),
		('3','20','30','2023-09-07 16:45:25.091'),
		('3','18','40','2023-10-07 16:45:25.091'),
		('3','15','50','2023-11-07 16:45:25.091'),
		('4','10','25','2023-12-07 16:45:25.091');
