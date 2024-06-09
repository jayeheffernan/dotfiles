venv:
	python3 -m venv venv

install:
	./venv/bin/pip install -r requirements.txt

freeze:
	./venv/bin/pip freeze > requirements.txt

format:
	./venv/bin/black .

lint:
	./venv/bin/flake8

