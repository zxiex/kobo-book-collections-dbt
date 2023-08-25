.PHONY: run compile install clean

run:
	pipenv run dbt run
compile:
	pipenv run dbt compile
install:
	git clone https://github.com/zxiex/dbt-sqlite.git
	pipenv install
clean:
	rm -rf dbt-sqlite
	pipenv --rm
