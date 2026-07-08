PROJECT_DIR=classicmodels_modeling
PROFILES_DIR=.

install:
	python -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt

up:
	docker compose up -d

deps:
	cd $(PROJECT_DIR) && dbt deps --profiles-dir ..

seed:
	cd $(PROJECT_DIR) && dbt seed --profiles-dir ..

build:
	cd $(PROJECT_DIR) && dbt build --profiles-dir ..

test:
	cd $(PROJECT_DIR) && dbt test --profiles-dir ..

docs:
	cd $(PROJECT_DIR) && dbt docs generate --profiles-dir .. && dbt docs serve --profiles-dir ..

clean:
	cd $(PROJECT_DIR) && dbt clean --profiles-dir ..
