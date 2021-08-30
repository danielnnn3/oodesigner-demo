namespace: Integrations.AOS_application
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.121
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
            - account_service_host: '${target_host_username}'
            - db_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos
    - install_aos:
        do:
          io.cloudslang.demo.aos.install_aos:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 331
        'y': 256
      install_java:
        x: 600
        'y': 271.734375
      install_tomcat:
        x: 802
        'y': 299.734375
      install_aos:
        x: 983
        'y': 314.734375
        navigate:
          ead17b19-9f4b-e7d5-d0c6-c5b87b03c49b:
            targetId: 461c34a4-6004-cd7f-ddd2-5e0b8418710b
            port: SUCCESS
    results:
      SUCCESS:
        461c34a4-6004-cd7f-ddd2-5e0b8418710b:
          x: 1179
          'y': 311
