# Fraud Detection Pipeline & ML System

Proyecto de ingeniería de datos y Machine Learning para la detección de transacciones fraudulentas en tarjetas de crédito utilizando Snowflake y Snowpark.

##  Descripción del Proyecto
El objetivo es construir un pipeline **ELT (Extract, Load, Transform)** completo siguiendo la arquitectura Medallion. El sistema ingesta datos transaccionales, los limpia y enriquece para finalmente alimentar un modelo de clasificación (XGBoost/Random Forest) capaz de predecir fraudes en tiempo real.

**Dataset:** Credit Card Transactions (Simulación de Sparkov - Versión Kartik Shenoy).
**Stack:** Snowflake, Python (Snowpark), SQL, Git.

## 🏗️ Arquitectura (Medallion)

| Capa | Esquema | Descripción | Estado |
| :--- | :--- | :--- | :--- |
| **Bronze** | `CARD_TRANSACTIONS.BRONZE` | Datos crudos (Raw) ingestados tal cual desde el CSV. |  Completado |
| **Silver** | `CARD_TRANSACTIONS.SILVER` | Datos limpios, tipados correctos, deduplicados y estandarizados. |  En Progreso |
| **Gold** | `CARD_TRANSACTIONS.GOLD` | Tablas de características (Features) y vistas de negocio listas para ML/BI. |  Pendiente | 

##  Estructura del Repositorio
```text
├── 00_setup/               # Configuración inicial de infraestructura (DBs, Roles, Stages)
├── 01_bronze/              # Ingesta de datos crudos
│   ├── data_exploration/   # Notebooks para EDA (Exploratory Data Analysis) inicial
│   └── load_raw_*.sql      # Scripts de COPY INTO para tablas Raw
├── 02_silver/              # Lógica de limpieza y transformación (SQL/Snowpark)
├── 03_gold/                # Agregaciones y Feature Engineering
└── README.md
