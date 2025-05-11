from airflow import DAG
from airflow.operators.bash import BashOperator

from datetime import datetime, timedelta


with DAG(
    dag_id="full_pipeline",
    start_date=datetime(2023, 9, 1),
    schedule_interval="@hourly",
    catchup=False,
    tags=["DE-test"],
    default_args={
        "owner": "airflow",
        "retries": 1,
        "retry_delay": timedelta(minutes=5),
    },
    
) as dag:
    
    ingest = BashOperator(
        task_id="mod_1_ingest",
        bash_command="""
                    {% raw %}
                    cd /opt/pipeline/modules/01_ingest && bash airflow_check.sh
                    {% endraw %}
                    """,
    )

    transform = BashOperator(
        task_id="mod_2_transform",
        bash_command="""
                    {% raw %}
                    cd /opt/pipeline/modules/02_dbt && bash airflow_check.sh
                    {% endraw %}
                    """,
    )

    ingest >> transform