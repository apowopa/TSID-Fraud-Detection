from snowflake.snowpark import Session
from snowflake.snowpark.functions import (
    col, year, month, hour, min, max, count, avg, when # <-- Se importa 'when'
)

def main(session: Session):

    print("\n=== Cargando tabla RAW_TRANSACTIONS ===\n")

    # =============================================================
    # 1. Cargar tabla BRONZE
    # =============================================================
    df = session.table("CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS")

    print("Primeras filas:")
    df.show(5)

    # =============================================================
    # 2. Total de registros
    # =============================================================
    total = df.count()
    print("\n=== Total de registros ===")
    print(total)

    # =============================================================
    # 3. Transacciones por Año y Mes
    # =============================================================
    df_ym = (
        df.select(
            year(col("TRANS_DATE_TRANS_TIME")).alias("ANIO"),
            month(col("TRANS_DATE_TRANS_TIME")).alias("MES")
        )
        .group_by("ANIO", "MES")
        .count()
        .sort("ANIO", "MES")
    )

    print("\n=== Transacciones por Año y Mes ===")
    df_ym.show()

    # =============================================================
    # 4. Transacciones por Hora
    # =============================================================
    df_horas = (
        df.select(hour(col("TRANS_DATE_TRANS_TIME")).alias("HORA"))
            .group_by("HORA")
            .count()
            .sort("HORA")
    )

    print("\n=== Transacciones por Hora ===")
    df_horas.show()

    # =============================================================
    # 5. Mínimo y Máximo monto
    # =============================================================
    df_minmax = df.select(
        min(col("AMT")).alias("MONTO_MINIMO"),
        max(col("AMT")).alias("MONTO_MAXIMO")
    )

    print("\n=== Mínimo y Máximo monto ===")
    df_minmax.show()

    # =============================================================
    # 6. Rango de montos (CASE WHEN corregido con 'when')
    # =============================================================
    df_rangos = (
        df.select(
            # ¡CORRECCIÓN AQUÍ! Se usa 'when' directamente para empezar la expresión CASE
            when(col("AMT") < 10, "1. 0 - 10") 
            .when(col("AMT") < 50, "2. 10 - 50")
            .when(col("AMT") < 100, "3. 50 - 100")
            .when(col("AMT") < 200, "4. 100 - 200")
            .when(col("AMT") < 500, "5. 200 - 500")
            .when(col("AMT") < 1000, "6. 500 - 1000")
            .when(col("AMT") < 5000, "7. 1000 - 5000")
            .otherwise("8. 5000+")
            .alias("RANGO_MONTO")
        )
        .group_by("RANGO_MONTO")
        .count()
        .sort("RANGO_MONTO")
    )

    print("\n=== Rangos de montos ===")
    df_rangos.show()

    # =============================================================
    # 7. Distribución por Categoría
    # =============================================================
    df_categoria = (
        df.group_by(col("CATEGORY"))
            .count()
            .sort(col("COUNT").desc())
    )

    print("\n=== Distribución por Categoría ===")
    df_categoria.show()

    # =============================================================
    # 8. Comercios con más transacciones
    # =============================================================
    df_merchants = (
        df.group_by(col("MERCHANT"))
            .count()
            .sort(col("COUNT").desc())
    )

    print("\n=== Comercios con más transacciones ===")
    df_merchants.show()

    # 🔚 RETORNAMOS lo último (lo que quieras ver en Results)
    return df_merchants