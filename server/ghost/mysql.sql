CREATE DATABASE ghost;
CREATE USER 'ghost'@'%' IDENTIFIED BY 'ghost_db_passwd';
GRANT ALL ON `ghost`.* TO 'ghost'@'%';
