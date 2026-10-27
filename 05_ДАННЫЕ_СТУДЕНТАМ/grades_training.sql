-- Учебная база результатов дисциплин (тема 08).
-- Та же структура, что у основной базы в DBeaver (схема grades), но меньше данных.
-- Скрипт подходит для SQLite и PostgreSQL.

CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  student_name TEXT NOT NULL,
  group_code TEXT NOT NULL,
  faculty TEXT NOT NULL,
  direction_name TEXT NOT NULL,
  program_name TEXT NOT NULL
);

CREATE TABLE teachers (
  teacher_id INTEGER PRIMARY KEY,
  teacher_name TEXT NOT NULL
);

CREATE TABLE disciplines (
  discipline_id INTEGER PRIMARY KEY,
  discipline_name TEXT NOT NULL
);

CREATE TABLE streams (
  stream_id INTEGER PRIMARY KEY,
  discipline_id INTEGER NOT NULL,
  stream_name TEXT NOT NULL,
  stream_type TEXT NOT NULL,
  teacher_id INTEGER NOT NULL,
  parent_stream_id INTEGER,
  FOREIGN KEY (discipline_id) REFERENCES disciplines(discipline_id),
  FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
  FOREIGN KEY (parent_stream_id) REFERENCES streams(stream_id)
);

CREATE TABLE enrollments (
  student_id INTEGER NOT NULL,
  stream_id INTEGER NOT NULL,
  PRIMARY KEY (student_id, stream_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (stream_id) REFERENCES streams(stream_id)
);

CREATE TABLE results (
  result_id INTEGER PRIMARY KEY,
  student_id INTEGER NOT NULL,
  discipline_id INTEGER NOT NULL,
  stream_id INTEGER,
  assessment_date TEXT NOT NULL,
  score_value REAL,
  grade_value INTEGER,
  grade_status TEXT NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (discipline_id) REFERENCES disciplines(discipline_id),
  FOREIGN KEY (stream_id) REFERENCES streams(stream_id)
);

INSERT INTO students VALUES
(1, 'Алина Воронова', 'M3201', 'ФТМИ', 'Прикладная математика', 'Аналитика данных'),
(2, 'Борис Крылов', 'M3201', 'ФТМИ', 'Прикладная математика', 'Аналитика данных'),
(3, 'Виктория Смирнова', 'M3202', 'ФТМИ', 'Прикладная информатика', 'AI-аналитика'),
(4, 'Глеб Новиков', 'M3202', 'ФТМИ', 'Прикладная информатика', 'AI-аналитика'),
(5, 'Дарья Лаврова', 'M3301', 'ФЕН', 'Математика', 'Математическое моделирование'),
(6, 'Егор Селезнёв', 'M3301', 'ФЕН', 'Математика', 'Математическое моделирование'),
(7, 'Жанна Полякова', 'M3302', 'ФЕН', 'Статистика', 'Науки о данных'),
(8, 'Илья Терентьев', 'M3302', 'ФЕН', 'Статистика', 'Науки о данных'),
(9, 'Кира Фадеева', 'M3401', 'ФЦТ', 'Компьютерные системы', 'Интеллектуальные системы'),
(10, 'Лев Гурьев', 'M3401', 'ФЦТ', 'Компьютерные системы', 'Интеллектуальные системы');

INSERT INTO teachers VALUES
(1, 'Анна Миронова'),
(2, 'Павел Егоров'),
(3, 'Софья Литвинова'),
(4, 'Михаил Власов'),
(5, 'Наталья Осипова');

INSERT INTO disciplines VALUES
(1, 'Линейная алгебра'),
(2, 'Теория вероятностей'),
(3, 'Базы данных'),
(4, 'Математическая статистика');

INSERT INTO streams VALUES
(101, 1, 'Линейная алгебра · лекция A', 'lecture', 1, NULL),
(102, 1, 'Линейная алгебра · практика A1', 'practice', 2, 101),
(103, 1, 'Линейная алгебра · практика A2', 'practice', 3, 101),
(201, 2, 'Теория вероятностей · лекция B', 'lecture', 3, NULL),
(202, 2, 'Теория вероятностей · практика B1', 'practice', 4, 201),
(301, 3, 'Базы данных · лекция C', 'lecture', 5, NULL),
(302, 3, 'Базы данных · практика C1', 'practice', 5, 301),
(401, 4, 'Математическая статистика · лекция D', 'lecture', 4, NULL);

INSERT INTO enrollments VALUES
(1, 101),
(1, 102),
(1, 301),
(1, 302),
(2, 101),
(2, 103),
(2, 301),
(2, 302),
(3, 101),
(3, 102),
(3, 301),
(3, 302),
(4, 101),
(4, 103),
(4, 301),
(4, 302),
(5, 201),
(5, 202),
(5, 401),
(6, 201),
(6, 202),
(6, 401),
(7, 201),
(7, 202),
(7, 401),
(8, 201),
(8, 202),
(8, 401),
(9, 301),
(9, 302),
(9, 201),
(10, 301),
(10, 302),
(10, 201);

INSERT INTO results VALUES
(1, 1, 1, 102, '2026-02-10', 87, 5, 'graded'),
(2, 2, 1, 103, '2026-02-10', 78, 4, 'graded'),
(3, 3, 1, 102, '2026-02-11', 91, 5, 'graded'),
(4, 4, 1, 103, '2026-02-11', 62, 3, 'graded'),
(5, 5, 2, 202, '2026-02-14', 74, 4, 'graded'),
(6, 6, 2, 202, '2026-02-14', 55, 3, 'graded'),
(7, 7, 4, 401, '2026-02-18', 88, 5, 'graded'),
(8, 8, 4, 401, '2026-02-18', NULL, NULL, 'absent'),
(9, 9, 3, 302, '2026-02-21', 95, 5, 'graded'),
(10, 10, 3, 302, '2026-02-21', 81, 4, 'graded'),
(11, 3, 3, 302, '2026-02-21', 89, 5, 'graded'),
(12, 4, 3, 302, '2026-02-21', 67, 3, 'graded'),
(13, 1, 3, 302, '2026-02-21', 92, 5, 'graded'),
(14, 2, 3, 302, '2026-02-21', NULL, NULL, 'unknown');
