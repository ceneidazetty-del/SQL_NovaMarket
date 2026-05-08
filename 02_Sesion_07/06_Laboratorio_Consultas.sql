-- 💻 LABORATORIO SESIÓN 7: EL INTERROGATORIO (SQL en VS Code)
-- ═══════════════════════════════════════════════════════════════
-- Guía de Referencia: 02_Guia_S07_Antigravity.md
-- Base de Datos: Ceneida_Novamarket_S07.db (500 registros)
-- Estudiante: Ceneida Zetty
-- ═══════════════════════════════════════════════════════════════

-- INSTRUCCIONES:
-- 1. Escribe tu código debajo de cada bloque.
-- 2. Asegúrate de estar conectado a 'Novamarket_S07.db'.
-- 3. Para ejecutar: Selecciona tu código con el mouse y presiona Cmd + E.

-- ══ BLOQUE A — Exploración Inicial ═════════════════════════════

SELECT * FROM FactVentas LIMIT 10;

SELECT COUNT(*) AS Total_Transacciones FROM FactVentas;

-- ══ BLOQUE B — Columnas y Cálculos (Suma, Mult, Alias) ═════════
-- TIP: Si vas a dividir (ej. margen %), multiplica por 100.0 primero
-- para obligar a SQLite a trabajar con decimales.
-- Ejemplo: ROUND((Ganancia * 100.0) / Precio, 2) AS Porcentaje

SELECT
    TransaccionID,
    CiudadID,
    Cantidad,
    Precio_Venta,
    Descuento_Pct,
    (Precio_Venta * Cantidad)                             AS Venta_Bruta,
    (Precio_Venta * Cantidad * Descuento_Pct)             AS Descuento_Monto,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
LIMIT 20;

-- ══ BLOQUE C — Filtros WHERE (Leticia, Descuentos) ═════════════

SELECT TransaccionID, FechaID, CiudadID, Cantidad, Precio_Venta, Costo_Envio
FROM FactVentas
WHERE CiudadID = 6
ORDER BY FechaID;

SELECT
    TransaccionID, CiudadID, Descuento_Pct, Costo_Envio,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
WHERE CiudadID = 6
  AND Descuento_Pct > 0
ORDER BY Descuento_Pct DESC;

-- ══ BLOQUE D — Orden y Límites (Top 10, Peores Márgenes) ══════

SELECT
    TransaccionID,
    CiudadID,
    Precio_Venta,
    Cantidad,
    Descuento_Pct,
    Costo_Envio,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct) - Costo_Envio, 2)
        AS Margen_Aproximado
FROM FactVentas
ORDER BY Margen_Aproximado ASC
LIMIT 10;

-- ══ BLOQUE E — Desafíos Autónomos (ENTREGABLES) ════════════════

-- DESAFÍO 1: ¿Cuántas ventas hubo en septiembre 2023?
SELECT COUNT(*) AS Ventas_Sep
FROM FactVentas
WHERE FechaID BETWEEN 20230901 AND 20230930;

-- DESAFÍO 2: Muestra las 10 transacciones con mayor Descuento_Pct que no sean de Leticia
SELECT TransaccionID, CiudadID, Descuento_Pct, Precio_Venta
FROM FactVentas
WHERE CiudadID <> 6
ORDER BY Descuento_Pct DESC
LIMIT 10;

-- DESAFÍO 3: Ventas de noviembre con Descuento_Pct > 0.20 Y Costo_Envio > 500
SELECT COUNT(*) AS Ventas_Destructoras
FROM FactVentas
WHERE FechaID BETWEEN 20231101 AND 20231130
  AND Descuento_Pct > 0.20
  AND Costo_Envio > 500;

-- ═══════════════════════════════════════════════════════════════
-- Fin del Laboratorio 07
