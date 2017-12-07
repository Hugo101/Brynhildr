# Brynhildr
A repository for team project of CS6360

## File list
* project_report.pdf: ER Diagrams for project requirement 1.
* project_report.tex: ER Diagrams source file.
* sqls.txt: Sqls for project requirement 2.
* dump.sql: Test data of this project.
* Brynhildr: Web App Root Dir.
* Sigrdrifa: Frontend Root Dir.

## Application Structure (Undetermined)
* Database: Mysql (Requirement of Project)
* Backend: Flask, Restful API, Python3
* Frontend: Bootstrap, jQuery

## Front End
* Use bootstrap and jQuery for development
* Use blueimp's JavaScript-MD5 for frontend encryption:
https://github.com/blueimp/JavaScript-MD5
* Use Xdan's jQuery-datetimepicker:
https://github.com/xdan/datetimepicker

## Back End
Use some extension of Flask for development, includes:

* Flask-Restful
* Flask-HttpAuth
* Flask-MySQLdb
* Flask-Cors

## Deploy Manual

Require Python 3.6.3 and MySQL 5.7 installed

* Unix&Linux: ```./init_db.sh ; ./runserver.sh```
* Windows:    ```checkpython.bat; runserver.bat```

## License
* MIT License

