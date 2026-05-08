import sqlite3
import os

db_path = r'c:\Users\Asus\Downloads\SQL_NovaMarket-main\SQL_NovaMarket-main\02_Sesion_07\Novamarket_S07_ceneida.db'

def run_query(query):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    conn.close()
    return results

print("--- A2 ---")
print("Distribucion por ciudad:")
print(run_query("SELECT CiudadID, COUNT(*) AS Transacciones FROM FactVentas GROUP BY CiudadID ORDER BY Transacciones DESC;"))

print("\n--- A3 ---")
print("Productos con mayor margen %:")
print(run_query("SELECT Nombre, ROUND((Precio_Unitario - Costo_Unitario) / Precio_Unitario * 100, 1) AS Margen_Pct FROM DimProducto ORDER BY Margen_Pct DESC LIMIT 1;"))
print("Costo envio base Leticia (ID 6):")
print(run_query("SELECT Costo_Envio_Base FROM DimCiudad WHERE CiudadID = 6;"))

print("\n--- C1 ---")
print("Transacciones Leticia:")
print(run_query("SELECT COUNT(*) FROM FactVentas WHERE CiudadID = 6;"))

print("\n--- C2 ---")
print("Ventas descuento > 15%:")
print(run_query("SELECT COUNT(*) FROM FactVentas WHERE Descuento_Pct > 0.15;"))
print("Fecha de esas ventas (top counts):")
print(run_query("SELECT FechaID, COUNT(*) FROM FactVentas WHERE Descuento_Pct > 0.15 GROUP BY FechaID ORDER BY COUNT(*) DESC LIMIT 5;"))

print("\n--- C5 ---")
print("Ventas noviembre:")
print(run_query("SELECT COUNT(*) FROM FactVentas WHERE FechaID BETWEEN 20231101 AND 20231130;"))

print("\n--- C7 ---")
print("Dias con evento especial:")
print(run_query("SELECT COUNT(*) FROM DimFecha WHERE Evento_Especial IS NOT NULL;"))
print("Cual es el evento:")
print(run_query("SELECT FechaID, Evento_Especial FROM DimFecha WHERE Evento_Especial IS NOT NULL;"))

print("\n--- D1 ---")
print("Top 10 costo envio (CiudadID):")
print(run_query("SELECT CiudadID, COUNT(*) FROM (SELECT CiudadID FROM FactVentas ORDER BY Costo_Envio DESC LIMIT 10) GROUP BY CiudadID;"))

print("\n--- D2 ---")
print("Peor margen (Margen_Aproximado):")
print(run_query("SELECT CiudadID, ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct) - Costo_Envio, 2) AS Margen_Aproximado FROM FactVentas ORDER BY Margen_Aproximado ASC LIMIT 1;"))

print("\n--- Desafio 1 ---")
print("Ventas Septiembre:")
print(run_query("SELECT COUNT(*) FROM FactVentas WHERE FechaID BETWEEN 20230901 AND 20230930;"))

print("\n--- Desafio 3 ---")
print("Ventas destructoras:")
print(run_query("SELECT COUNT(*) FROM FactVentas WHERE FechaID BETWEEN 20231101 AND 20231130 AND Descuento_Pct > 0.20 AND Costo_Envio > 500;"))
