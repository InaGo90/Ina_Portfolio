# 1. Script para fenix_datos_personales.csv (Modificado)

import pandas as pd
import numpy as np

# Patinadoras clave (para asegurar que están)
estrella_fugaz_id = "FENIX_02"
nova_id = "FENIX_09"

data_personales = {
    'ID_Patinadora': [f"FENIX_{i:02d}" for i in range(1, 16)],
    'Nombre_Completo': [
        "Ana García Pérez", "Laura Martínez Soler (EstrellaFugaz)", "Sofía López Ruiz", "Carmen Hernández Gil",
        "Elena Torres Vázquez", "Isabel Romero Sáez", "Patricia Jiménez Moya", "Cristina Alonso Cabrera",
        "Raquel Navarro Vargas (Nova)", "Marta Castillo Ramos", "Beatriz Sanz Herrera", "Eva Méndez Fuentes",
        "Lorena Gilgado Ortiz", "Silvia Acosta Ponce", "Nerea Blanco Cortina"
    ],
    'Fecha_Nacimiento': [
        "2004-03-15", "2003-07-22", "2005-01-10", "2004-11-05", "2003-09-12",
        "2005-05-28", "2004-02-19", "2003-12-01", "2005-08-08", "2004-06-17",
        "2003-10-30", "2005-04-03", "2004-01-25", "2003-06-09", "2005-11-11"
    ],
    'Ciudad_Origen': [
        "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza", "Málaga", "Murcia",
        "Palma", "Bilbao", "Alicante", "Valladolid", "Vigo", "Gijón", "Granada", "A Coruña"
    ],
    'Especialidad_Principal': [
        "Saltos y Giros", "Velocidad y Resistencia", "Coreografía y Expresión", "Saltos y Flexibilidad",
        "Velocidad y Agilidad", "Coreografía y Saltos", "Resistencia y Técnica", "Giros y Flexibilidad",
        "Patinaje Total", "Expresión y Técnica", "Saltos y Agilidad", "Coreografía y Resistencia",
        "Velocidad", "Saltos", "Giros"
    ],
    'Notas_Club_Anterior': [
        np.nan, np.nan, np.nan, np.nan, np.nan, np.nan, np.nan, np.nan,
        "Gran potencial; algunos roces con compañeras, nada confirmado.", # Nota para Nova
        np.nan, np.nan, np.nan, np.nan, np.nan, np.nan
    ]
}
df_personales = pd.DataFrame(data_personales)

# Asegurar que los IDs clave estén bien
df_personales.loc[df_personales['ID_Patinadora'] == estrella_fugaz_id, 'Nombre_Completo'] = "Laura Martínez Soler (EstrellaFugaz)"
df_personales.loc[df_personales['ID_Patinadora'] == nova_id, 'Nombre_Completo'] = "Raquel Navarro Vargas (Nova)"
df_personales.loc[df_personales['ID_Patinadora'] == nova_id, 'Especialidad_Principal'] = "Patinaje Total"


df_personales.to_csv('fenix_datos_personales.csv', sep=';', index=False, encoding='utf-8-sig')
print("Archivo 'fenix_datos_personales.csv' (con salseo) creado exitosamente.")
print(df_personales[df_personales['ID_Patinadora'].isin([estrella_fugaz_id, nova_id])])

# 2. Script para fenix_equipamiento.csv 

import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

# Configuración
num_rows_equip = 25 
patinadora_ids_all = [f"FENIX_{i:02d}" for i in range(1, 16)]
estrella_fugaz_id = "FENIX_02"
nova_id = "FENIX_09"
start_date = datetime(2024, 8, 1)
end_date = datetime(2024, 10, 31)
time_delta_days = (end_date - start_date).days

tipos_articulo_base = [
    "Patines Competicion Alpha", "Ruedas Dureza 92A", "Protecciones Rodilla Pro",
    "Botas Modelo Elite", "Cuchillas Figura Master", "Patines Entrenamiento Beta",
    "Ruedas Agarre Extremo 88A", "Casco Aero Dinamic"
]
estados_base = ["Nuevo", "Bueno", "Usado"]
desgaste_base = ["Ninguno", "Leve", "Medio", "Alto", np.nan]


data_equipamiento = []
for i in range(1, num_rows_equip + 1):
    pat_id = random.choice(patinadora_ids_all)
    fecha_adq_dt = start_date - timedelta(days=random.randint(30, 365)) # Adquirido antes del periodo de sesiones
    fecha_adq_str = fecha_adq_dt.strftime('%Y-%m-%d')
    
    tipo_art = random.choice(tipos_articulo_base)
    estado = random.choice(estados_base)
    desgaste = random.choice(desgaste_base)

    # Salseo específico
    if pat_id == estrella_fugaz_id and random.random() < 0.4: # 40% prob para Estrella
        estado = random.choice(["Deteriorado_Rapido", "Usado"])
        desgaste = random.choice(["Anómalo", "Alto_Inesperado", "Roto"])
        if random.random() < 0.5:
            tipo_art = "Patines Competicion Alpha" # Su material principal
    elif pat_id == nova_id and random.random() < 0.3: # 30% prob para Nova
        tipo_art = "Prototipo Experimental Z-99"
        estado = "Impecable"
        desgaste = "Como nuevo"

    data_equipamiento.append({
        'ID_Registro_Equip': f"EQ{i:03d}",
        'ID_Patinadora': pat_id,
        'Tipo_Articulo': tipo_art, # Renombrada para evitar conflicto con df_material_tf
        'Marca_Modelo_Equip': f"Marca_{random.choice(['X','Y','Z'])}_{random.randint(100,999)}",
        'Fecha_Adquisicion': fecha_adq_str,
        'Estado_Actual': estado,
        'Desgaste_Observado': desgaste # Nueva columna para más detalle
    })

df_equipamiento = pd.DataFrame(data_equipamiento)
df_equipamiento.to_csv('fenix_equipamiento.csv', sep=';', index=False, encoding='utf--8-sig')
print("Archivo 'fenix_equipamiento.csv' (con salseo) creado exitosamente.")
print("\nEjemplos para EstrellaFugaz77 (FENIX_02):")
print(df_equipamiento[df_equipamiento['ID_Patinadora'] == estrella_fugaz_id].head())
print("\nEjemplos para NovaProdigy21 (FENIX_09):")
print(df_equipamiento[df_equipamiento['ID_Patinadora'] == nova_id].head())

# 3. Script para fenix_resultados_parcial_1.csv (Modificado)

import pandas as pd
import numpy as np
import random

estrella_fugaz_id = "FENIX_02"
nova_id = "FENIX_09"

data_resultados_1 = {
    'ID_Patinadora': ["FENIX_01", estrella_fugaz_id, "FENIX_05", "FENIX_07", nova_id, "FENIX_11", "FENIX_13"],
    'Alias_Patinadora_Comp': ["Relámpago", "EstrellaFugaz77", "SombraVeloz42", "Esquirla23", "NovaProdigy21", "ZigZg7", "HuracnBlanco9"],
    'Nombre_Competicion': ["Trofeo Verano Ciudad"] * 7,
    'Fecha_Competicion': ["2024-09-15"] * 7,
    'Puntuacion_Final_Comp': [85.60, 79.50, 78.90, 83.10, 90.50, 80.00, 77.20],
    'Posicion_Comp': [2, 4, 5, 3, 1, 6, 7] 
}
df_resultados_1 = pd.DataFrame(data_resultados_1)
df_resultados_1.to_csv('fenix_resultados_parcial_1.csv', sep=';', index=False, encoding='utf-8-sig')
print("Archivo 'fenix_resultados_parcial_1.csv' (con salseo) creado exitosamente.")
print(df_resultados_1[df_resultados_1['ID_Patinadora'].isin([estrella_fugaz_id, nova_id])])

# 4. Script para fenix_resultados_parcial_2.csv (Modificado)

import pandas as pd
import numpy as np
import random

estrella_fugaz_id = "FENIX_02"
nova_id = "FENIX_09"

data_resultados_2 = {
    'ID_Patinadora': ["FENIX_04", estrella_fugaz_id, "FENIX_08", nova_id, "FENIX_12", "FENIX_14", "FENIX_06"],
    'Alias_Patinadora_Comp': ["CometaRoja33", "EstrellaFugaz77", "Vndaval19", "NovaProdigy21", "Eclpse4", "CentllaNegra1", "Dinamita15"],
    'Nombre_Competicion': ["Copa Otoño Élite"] * 7,
    'Fecha_Competicion': ["2024-10-25"] * 7, 
    'Puntuacion_Final_Comp': [88.50, 65.20, 82.70, 93.00, 75.80, 78.00, 85.00], # Estrella muy baja, Nova la más alta
    'Posicion_Comp': [3, 10, 4, 1, 7, 6, 2] # Estrella muy atrás, Nova gana
}
df_resultados_2 = pd.DataFrame(data_resultados_2)
df_resultados_2.to_csv('fenix_resultados_parcial_2.csv', sep=';', index=False, encoding='utf-8-sig')
print("Archivo 'fenix_resultados_parcial_2.csv' (con salseo) creado exitosamente.")
print(df_resultados_2[df_resultados_2['ID_Patinadora'].isin([estrella_fugaz_id, nova_id])])