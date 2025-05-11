
FROM apache/airflow:2.9.1

USER airflow

# allow pip-as-root so we can install into the container Python env
ENV PIP_ALLOW_ROOT=1

RUN pip install --no-cache-dir \
      psycopg2-binary \
      "dbt-postgres==1.9.0"

USER airflow
