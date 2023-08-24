.PHONY: run compile
run:
	pipenv run dbt run
compile:
	pipenv run dbt compile
