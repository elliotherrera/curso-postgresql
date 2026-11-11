<div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.65; color: #e2e8f0; max-width: 980px; margin: 0 auto; padding: 8px;">

<!-- HERO -->
<div style="position: relative; overflow: hidden; border-radius: 20px; padding: 40px 32px; background: linear-gradient(135deg, #0f0c29 0%, #302b63 45%, #6d28d9 100%); box-shadow: 0 20px 50px -12px rgba(109,40,217,0.6), inset 0 1px 0 rgba(255,255,255,0.08); margin-bottom: 28px; border: 1px solid rgba(139,92,246,0.25);">
  <div style="position:absolute; top:-60px; right:-60px; width:240px; height:240px; border-radius:50%; background: radial-gradient(circle, rgba(236,72,153,0.6), transparent 70%); filter: blur(10px);"></div>
  <div style="position:absolute; bottom:-90px; left:-50px; width:280px; height:280px; border-radius:50%; background: radial-gradient(circle, rgba(59,130,246,0.5), transparent 70%); filter: blur(10px);"></div>
  <div style="position:relative;">
    <div style="display:inline-block; background:rgba(139,92,246,0.2); border:1px solid rgba(167,139,250,0.5); color:#c4b5fd; font-size:0.72em; letter-spacing:2px; font-weight:700; padding:5px 14px; border-radius:999px; margin-bottom:14px;">CLASE 005 · POSTGRESQL</div>
    <h1 style="margin:0 0 12px 0; font-size:2.3em; font-weight:800; color:#ffffff; line-height:1.15; letter-spacing:-0.5px; text-shadow: 0 2px 20px rgba(167,139,250,0.4);">Números decimales</h1>
    <p style="margin:0; color:#cbd5e1; font-size:1.05em; font-weight:500;">Elegir entre <span style="background:#fde047; color:#422006; padding:2px 10px; border-radius:6px; font-weight:700;">exactitud</span> y <span style="background:#fb923c; color:#431407; padding:2px 10px; border-radius:6px; font-weight:700;">aproximación</span> según el dato.</p>
    <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:20px;">
      <span style="background:linear-gradient(135deg,#10b981,#047857); color:white; padding:8px 18px; border-radius:10px; font-weight:700; font-size:0.9em; box-shadow:0 6px 20px -4px rgba(16,185,129,0.7);">NUMERIC</span>
      <span style="background:linear-gradient(135deg,#f97316,#c2410c); color:white; padding:8px 18px; border-radius:10px; font-weight:700; font-size:0.9em; box-shadow:0 6px 20px -4px rgba(249,115,22,0.7);">REAL</span>
      <span style="background:linear-gradient(135deg,#ef4444,#991b1b); color:white; padding:8px 18px; border-radius:10px; font-weight:700; font-size:0.9em; box-shadow:0 6px 20px -4px rgba(239,68,68,0.7);">DOUBLE PRECISION</span>
    </div>
  </div>
</div>

<!-- OBJETIVO -->
<div style="background: linear-gradient(135deg, #1e1b4b, #312e81); border-left: 6px solid #a78bfa; border-radius: 14px; padding: 20px 24px; margin-bottom: 28px; box-shadow: 0 8px 24px -10px rgba(139,92,246,0.5); border: 1px solid rgba(139,92,246,0.3); border-left-width: 6px;">
  <div style="font-size:0.78em; letter-spacing:2px; font-weight:800; color:#a78bfa; margin-bottom:6px;">OBJETIVO</div>
  <div style="font-size:1.02em; color:#e0e7ff;">
    Elegir el tipo decimal correcto según si el dato exige <strong style="color:#c4b5fd;">exactitud</strong> (dinero) o solo una <strong style="color:#fbbf24;">aproximación suficiente</strong> (mediciones).
  </div>
</div>

<!-- CONCEPTO -->
<h2 style="display:flex; align-items:center; gap:12px; color:#f1f5f9; font-size:1.5em; margin: 32px 0 16px 0;">
  <span style="display:inline-block; width:8px; height:28px; background: linear-gradient(180deg,#a78bfa,#ec4899); border-radius:4px; box-shadow: 0 0 20px rgba(167,139,250,0.6);"></span>
  Concepto
</h2>

<div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap:16px;">
  <div style="background: linear-gradient(160deg, #052e26, #064e3b); border-radius:16px; padding:22px; border-top:5px solid #10b981; box-shadow: 0 12px 28px -14px rgba(16,185,129,0.7); border: 1px solid rgba(16,185,129,0.25); border-top-width: 5px;">
    <div style="font-weight:800; color:#6ee7b7; font-size:1.1em; margin-bottom:8px;">NUMERIC / DECIMAL</div>
    <div style="color:#d1fae5; font-size:0.95em;">Almacena el número de forma <strong style="color:#a7f3d0;">exacta</strong>, con la precisión y escala que definas.</div>
  </div>
  <div style="background: linear-gradient(160deg, #431407, #7c2d12); border-radius:16px; padding:22px; border-top:5px solid #f97316; box-shadow: 0 12px 28px -14px rgba(249,115,22,0.7); border: 1px solid rgba(249,115,22,0.3); border-top-width: 5px;">
    <div style="font-weight:800; color:#fdba74; font-size:1.1em; margin-bottom:8px;">REAL / DOUBLE PRECISION</div>
    <div style="color:#fed7aa; font-size:0.95em;">Almacenan una <strong style="color:#fdba74;">aproximación binaria</strong>. Rápidos y compactos, pero no representan exactamente todos los decimales.</div>
  </div>
</div>

<!-- COMPARACIÓN -->
<h2 style="display:flex; align-items:center; gap:12px; color:#f1f5f9; font-size:1.5em; margin: 36px 0 16px 0;">
  <span style="display:inline-block; width:8px; height:28px; background: linear-gradient(180deg,#3b82f6,#06b6d4); border-radius:4px; box-shadow: 0 0 20px rgba(59,130,246,0.6);"></span>
  Comparación
</h2>

<div style="border-radius:16px; overflow:hidden; box-shadow: 0 14px 36px -16px rgba(0,0,0,0.8); border: 1px solid rgba(139,92,246,0.25);">
<table style="border-collapse: collapse; width:100%; font-size:0.92em;">
  <thead>
    <tr style="background: linear-gradient(90deg,#312e81,#6d28d9,#be185d); color:white;">
      <th style="padding:14px; text-align:left; font-weight:700;">Tipo</th>
      <th style="padding:14px; text-align:left; font-weight:700;">Espacio</th>
      <th style="padding:14px; text-align:left; font-weight:700;">Precisión</th>
      <th style="padding:14px; text-align:left; font-weight:700;">Resultado</th>
    </tr>
  </thead>
  <tbody>
    <tr style="background:#0a2e26;">
      <td style="padding:14px; border-bottom:1px solid rgba(16,185,129,0.2);"><code style="background:#10b981; color:#022c22; padding:3px 8px; border-radius:6px; font-weight:800;">NUMERIC(p,s)</code></td>
      <td style="padding:14px; border-bottom:1px solid rgba(16,185,129,0.2); color:#a7f3d0;">variable</td>
      <td style="padding:14px; border-bottom:1px solid rgba(16,185,129,0.2); color:#a7f3d0;">exacta; hasta 131072 dígitos antes del punto y 16383 después</td>
      <td style="padding:14px; border-bottom:1px solid rgba(16,185,129,0.2);"><span style="background: linear-gradient(135deg,#10b981,#047857); color:white; padding:5px 12px; border-radius:999px; font-size:0.82em; font-weight:800; letter-spacing:0.5px; box-shadow:0 0 16px rgba(16,185,129,0.6);">EXACTO</span></td>
    </tr>
    <tr style="background:#2a1408;">
      <td style="padding:14px; border-bottom:1px solid rgba(249,115,22,0.25);"><code style="background:#f97316; color:#431407; padding:3px 8px; border-radius:6px; font-weight:800;">REAL</code></td>
      <td style="padding:14px; border-bottom:1px solid rgba(249,115,22,0.25); color:#fed7aa;">4 bytes</td>
      <td style="padding:14px; border-bottom:1px solid rgba(249,115,22,0.25); color:#fed7aa;">aprox. 6 dígitos significativos</td>
      <td style="padding:14px; border-bottom:1px solid rgba(249,115,22,0.25);"><span style="background: linear-gradient(135deg,#f97316,#c2410c); color:white; padding:5px 12px; border-radius:999px; font-size:0.82em; font-weight:800; letter-spacing:0.5px; box-shadow:0 0 16px rgba(249,115,22,0.6);">APROXIMADO</span></td>
    </tr>
    <tr style="background:#2e0a0a;">
      <td style="padding:14px;"><code style="background:#ef4444; color:#450a0a; padding:3px 8px; border-radius:6px; font-weight:800;">DOUBLE PRECISION</code></td>
      <td style="padding:14px; color:#fecaca;">8 bytes</td>
      <td style="padding:14px; color:#fecaca;">aprox. 15 dígitos significativos</td>
      <td style="padding:14px;"><span style="background: linear-gradient(135deg,#ef4444,#991b1b); color:white; padding:5px 12px; border-radius:999px; font-size:0.82em; font-weight:800; letter-spacing:0.5px; box-shadow:0 0 16px rgba(239,68,68,0.6);">APROXIMADO</span></td>
    </tr>
  </tbody>
</table>
</div>

<!-- SINTAXIS -->
<h2 style="display:flex; align-items:center; gap:12px; color:#f1f5f9; font-size:1.5em; margin: 36px 0 16px 0;">
  <span style="display:inline-block; width:8px; height:28px; background: linear-gradient(180deg,#f59e0b,#ef4444); border-radius:4px; box-shadow: 0 0 20px rgba(245,158,11,0.6);"></span>
  Sintaxis
</h2>

```sql
nombre_columna  NUMERIC(precision, escala)
nombre_columna  NUMERIC
nombre_columna  REAL
nombre_columna  DOUBLE PRECISION
```

<div style="background: linear-gradient(135deg,#2a1d03,#451a03); border-radius:14px; padding:20px 24px; border:1px solid rgba(245,158,11,0.35); margin-top:12px; box-shadow: 0 10px 26px -16px rgba(245,158,11,0.6);">
  <ul style="margin:0; padding-left:22px; color:#fde68a; font-size:0.95em;">
    <li style="margin-bottom:6px;"><strong style="color:#fbbf24;">precision</strong>: cantidad total de dígitos (antes y después del punto).</li>
    <li style="margin-bottom:6px;"><strong style="color:#fbbf24;">escala</strong>: cuántos de esos dígitos van después del punto.</li>
    <li style="margin-bottom:6px;"><strong style="color:#fbbf24;">dígitos enteros permitidos</strong> = <code style="background:#f59e0b; color:#422006; padding:2px 6px; border-radius:4px; font-weight:700;">precision − escala</code>.</li>
    <li style="margin-bottom:6px;"><code style="background:#f59e0b; color:#422006; padding:2px 6px; border-radius:4px; font-weight:700;">NUMERIC</code> sin argumentos: guarda el valor tal como se inserta, sin límite práctico.</li>
    <li><code style="background:#f59e0b; color:#422006; padding:2px 6px; border-radius:4px; font-weight:700;">NUMERIC(p)</code> equivale a <code style="background:#f59e0b; color:#422006; padding:2px 6px; border-radius:4px; font-weight:700;">NUMERIC(p, 0)</code>, es decir, sin decimales.</li>
  </ul>
</div>

<!-- CASOS DE USO -->
<h2 style="display:flex; align-items:center; gap:12px; color:#f1f5f9; font-size:1.5em; margin: 36px 0 16px 0;">
  <span style="display:inline-block; width:8px; height:28px; background: linear-gradient(180deg,#10b981,#06b6d4); border-radius:4px; box-shadow: 0 0 20px rgba(16,185,129,0.6);"></span>
  Casos de uso
</h2>

<div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(230px, 1fr)); gap:16px;">
  <div style="background: linear-gradient(160deg,#0c1e3e,#1e3a8a); border-radius:16px; padding:22px; box-shadow: 0 12px 28px -16px rgba(59,130,246,0.8); border: 1px solid rgba(59,130,246,0.3);">
    <div style="width:44px; height:44px; border-radius:12px; background: linear-gradient(135deg,#3b82f6,#1d4ed8); color:white; display:flex; align-items:center; justify-content:center; font-weight:800; font-size:1.3em; margin-bottom:14px; box-shadow:0 0 20px rgba(59,130,246,0.6);">1</div>
    <div style="font-weight:800; color:#93c5fd; font-size:1.05em; margin-bottom:6px;">Precios, saldos e impuestos</div>
    <div style="font-size:0.9em; color:#dbeafe;">Usa <code style="background:#3b82f6; color:#0c1e3e; padding:2px 6px; border-radius:4px; font-weight:700;">NUMERIC</code>, porque cada centavo debe cuadrar.</div>
  </div>
  <div style="background: linear-gradient(160deg,#3b0522,#831843); border-radius:16px; padding:22px; box-shadow: 0 12px 28px -16px rgba(236,72,153,0.8); border: 1px solid rgba(236,72,153,0.3);">
    <div style="width:44px; height:44px; border-radius:12px; background: linear-gradient(135deg,#ec4899,#be185d); color:white; display:flex; align-items:center; justify-content:center; font-weight:800; font-size:1.3em; margin-bottom:14px; box-shadow:0 0 20px rgba(236,72,153,0.6);">2</div>
    <div style="font-weight:800; color:#f9a8d4; font-size:1.05em; margin-bottom:6px;">Mediciones (temp, presión, pH)</div>
    <div style="font-size:0.9em; color:#fce7f3;"><code style="background:#ec4899; color:#3b0522; padding:2px 6px; border-radius:4px; font-weight:700;">DOUBLE PRECISION</code> o <code style="background:#ec4899; color:#3b0522; padding:2px 6px; border-radius:4px; font-weight:700;">NUMERIC</code> según la exactitud requerida.</div>
  </div>
  <div style="background: linear-gradient(160deg,#3a2a02,#713f12); border-radius:16px; padding:22px; box-shadow: 0 12px 28px -16px rgba(234,179,8,0.8); border: 1px solid rgba(234,179,8,0.3);">
    <div style="width:44px; height:44px; border-radius:12px; background: linear-gradient(135deg,#eab308,#a16207); color:white; display:flex; align-items:center; justify-content:center; font-weight:800; font-size:1.3em; margin-bottom:14px; box-shadow:0 0 20px rgba(234,179,8,0.6);">3</div>
    <div style="font-weight:800; color:#fde047; font-size:1.05em; margin-bottom:6px;">Coordenadas y estadística</div>
    <div style="font-size:0.9em; color:#fef9c3;"><code style="background:#eab308; color:#3a2a02; padding:2px 6px; border-radius:4px; font-weight:700;">DOUBLE PRECISION</code>, donde una diferencia microscópica no afecta el análisis.</div>
  </div>
</div>

<!-- EJEMPLOS -->
<h2 style="display:flex; align-items:center; gap:12px; color:#f1f5f9; font-size:1.5em; margin: 36px 0 16px 0;">
  <span style="display:inline-block; width:8px; height:28px; background: linear-gradient(180deg,#06b6d4,#8b5cf6); border-radius:4px; box-shadow: 0 0 20px rgba(6,182,212,0.6);"></span>
  Ejemplos
</h2>

<!-- Ejemplo 1 -->
<div style="background: linear-gradient(160deg,#052e2b,#0f766e); border-radius:18px; padding:24px; margin-bottom:20px; box-shadow: 0 14px 36px -18px rgba(6,182,212,0.7); border: 1px solid rgba(6,182,212,0.3);">
  <div style="display:inline-block; background:#06b6d4; color:#022c22; padding:4px 12px; border-radius:8px; font-size:0.78em; font-weight:800; letter-spacing:1px; margin-bottom:10px; box-shadow:0 0 16px rgba(6,182,212,0.5);">EJEMPLO 1</div>
  <h3 style="margin:0 0 8px 0; color:#f1f5f9; font-size:1.15em;">La misma cifra en los tres tipos</h3>
  <p style="font-size:0.9em; color:#cbd5e1; margin:0 0 14px 0;">Tabla <code style="background:#06b6d4; color:#022c22; padding:2px 6px; border-radius:4px; font-weight:700;">catalogo_demo</code> (id INTEGER, producto VARCHAR(20), precio NUMERIC(8,2), peso_real REAL, peso_doble DOUBLE PRECISION).</p>

```sql
SELECT * FROM catalogo_demo;
```

  <div style="border-radius:12px; overflow:hidden; margin-top:12px; border: 1px solid rgba(6,182,212,0.3);">
  <table style="border-collapse: collapse; width:100%; font-size:0.9em; background:#0c1f24;">
    <thead>
      <tr style="background: linear-gradient(90deg,#0e7490,#155e75); color:white;">
        <th style="padding:11px; text-align:left;">id</th>
        <th style="padding:11px; text-align:left;">producto</th>
        <th style="padding:11px; text-align:left;">precio</th>
        <th style="padding:11px; text-align:left;">peso_real</th>
        <th style="padding:11px; text-align:left;">peso_doble</th>
      </tr>
    </thead>
    <tbody>
      <tr style="background:#082025;">
        <td style="padding:10px; color:#e2e8f0;">1</td><td style="padding:10px; color:#e2e8f0;">Cafe molido</td>
        <td style="padding:10px; color:#34d399; font-weight:700;">3.10</td>
        <td style="padding:10px; color:#fb923c;">1234567.9</td>
        <td style="padding:10px; color:#60a5fa;">1234567.891</td>
      </tr>
      <tr>
        <td style="padding:10px; color:#e2e8f0;">2</td><td style="padding:10px; color:#e2e8f0;">Te verde</td>
        <td style="padding:10px; color:#34d399; font-weight:700;">5.68</td>
        <td style="padding:10px; color:#fb923c;">0.1</td>
        <td style="padding:10px; color:#60a5fa;">0.1</td>
      </tr>
      <tr style="background:#082025;">
        <td style="padding:10px; color:#e2e8f0;">3</td><td style="padding:10px; color:#e2e8f0;">Cacao</td>
        <td style="padding:10px; color:#34d399; font-weight:700;">12.50</td>
        <td style="padding:10px; color:#fb923c;">16777216</td>
        <td style="padding:10px; color:#60a5fa;">16777217</td>
      </tr>
    </tbody>
  </table>
  </div>

  <div style="background:#0c1f24; border-left:4px solid #a78bfa; padding:14px 18px; border-radius:8px; margin-top:14px; font-size:0.9em; color:#e9d5ff;">
    <strong style="color:#c4b5fd;">Lectura:</strong> <code style="background:#4c1d95; color:#e9d5ff; padding:2px 6px; border-radius:4px;">NUMERIC(8,2)</code> siempre muestra 2 decimales (<code>3.1 → 3.10</code>) y redondea lo que sobra (<code>5.678 → 5.68</code>). <code style="background:#7c2d12; color:#fed7aa; padding:2px 6px; border-radius:4px;">REAL</code> perdió dígitos; <code style="background:#1e3a8a; color:#dbeafe; padding:2px 6px; border-radius:4px;">DOUBLE PRECISION</code> los conservó.
  </div>
</div>

<!-- Ejemplo 2 -->
<div style="background: linear-gradient(160deg,#3a0a0a,#7f1d1d); border-radius:18px; padding:24px; margin-bottom:20px; box-shadow: 0 14px 36px -18px rgba(239,68,68,0.7); border: 1px solid rgba(239,68,68,0.3);">
  <div style="display:inline-block; background:#ef4444; color:#450a0a; padding:4px 12px; border-radius:8px; font-size:0.78em; font-weight:800; letter-spacing:1px; margin-bottom:10px; box-shadow:0 0 16px rgba(239,68,68,0.5);">EJEMPLO 2</div>
  <h3 style="margin:0 0 8px 0; color:#f1f5f9; font-size:1.15em;">El límite de NUMERIC(5,2)</h3>
  <p style="font-size:0.9em; color:#cbd5e1; margin:0 0 14px 0;">Tabla <code style="background:#ef4444; color:#450a0a; padding:2px 6px; border-radius:4px; font-weight:700;">sensores_demo</code> (id INTEGER, sensor VARCHAR(10), temperatura NUMERIC(5,2)).</p>

```sql
SELECT * FROM sensores_demo;
```

  <div style="border-radius:12px; overflow:hidden; margin-top:12px; border: 1px solid rgba(239,68,68,0.3);">
  <table style="border-collapse: collapse; width:100%; font-size:0.9em; background:#240a0a;">
    <thead>
      <tr style="background: linear-gradient(90deg,#b91c1c,#7f1d1d); color:white;">
        <th style="padding:11px; text-align:left;">id</th>
        <th style="padding:11px; text-align:left;">sensor</th>
        <th style="padding:11px; text-align:left;">temperatura</th>
      </tr>
    </thead>
    <tbody>
      <tr style="background:#1a0606;"><td style="padding:10px; color:#e2e8f0;">1</td><td style="padding:10px; color:#e2e8f0;">Horno A</td><td style="padding:10px; color:#fca5a5;">99.50</td></tr>
      <tr><td style="padding:10px; color:#e2e8f0;">2</td><td style="padding:10px; color:#e2e8f0;">Horno B</td><td style="padding:10px; color:#fca5a5;">100.00</td></tr>
      <tr style="background:#1a0606;"><td style="padding:10px; color:#e2e8f0;">3</td><td style="padding:10px; color:#e2e8f0;">Camara</td><td style="padding:10px; color:#fca5a5;">-12.35</td></tr>
      <tr><td style="padding:10px; color:#e2e8f0;">4</td><td style="padding:10px; color:#e2e8f0;">Entrada</td><td style="padding:10px; color:#fca5a5;">0.00</td></tr>
    </tbody>
  </table>
  </div>

  <div style="background:#240a0a; border-left:4px solid #ef4444; padding:14px 18px; border-radius:8px; margin-top:14px; font-size:0.9em; color:#fecaca;">
    Con <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">precision 5</code> y <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">escala 2</code> quedan <strong style="color:#fca5a5;">3 dígitos enteros</strong>: el valor máximo es <strong style="color:#fca5a5;">999.99</strong>. Insertar <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">1000</code> produce
    <span style="display:inline-block; background:#dc2626; color:white; padding:3px 10px; border-radius:6px; font-family:monospace; font-size:0.85em; font-weight:700; margin-top:6px; box-shadow:0 0 16px rgba(239,68,68,0.6);">ERROR: numeric field overflow</span>
  </div>
</div>

<!-- Ejemplo 3 -->
<div style="background: linear-gradient(160deg,#1e1b4b,#4c1d95); border-radius:18px; padding:24px; margin-bottom:20px; box-shadow: 0 14px 36px -18px rgba(139,92,246,0.7); border: 1px solid rgba(139,92,246,0.35);">
  <div style="display:inline-block; background:#a78bfa; color:#1e1b4b; padding:4px 12px; border-radius:8px; font-size:0.78em; font-weight:800; letter-spacing:1px; margin-bottom:10px; box-shadow:0 0 16px rgba(167,139,250,0.6);">EJEMPLO 3</div>
  <h3 style="margin:0 0 8px 0; color:#f1f5f9; font-size:1.15em;">NUMERIC sin precisión ni escala</h3>
  <p style="font-size:0.9em; color:#cbd5e1; margin:0 0 14px 0;">Tabla <code style="background:#a78bfa; color:#1e1b4b; padding:2px 6px; border-radius:4px; font-weight:700;">tarifas_demo</code> (id INTEGER, concepto VARCHAR(12), tasa NUMERIC).</p>

```sql
SELECT * FROM tarifas_demo;
```

  <div style="border-radius:12px; overflow:hidden; margin-top:12px; border: 1px solid rgba(139,92,246,0.35);">
  <table style="border-collapse: collapse; width:100%; font-size:0.9em; background:#1a1730;">
    <thead>
      <tr style="background: linear-gradient(90deg,#6d28d9,#4c1d95); color:white;">
        <th style="padding:11px; text-align:left;">id</th>
        <th style="padding:11px; text-align:left;">concepto</th>
        <th style="padding:11px; text-align:left;">tasa</th>
      </tr>
    </thead>
    <tbody>
      <tr style="background:#141129;"><td style="padding:10px; color:#e2e8f0;">1</td><td style="padding:10px; color:#e2e8f0;">Comision</td><td style="padding:10px; color:#c4b5fd;">0.075</td></tr>
      <tr><td style="padding:10px; color:#e2e8f0;">2</td><td style="padding:10px; color:#e2e8f0;">Cargo fijo</td><td style="padding:10px; color:#c4b5fd;">12</td></tr>
      <tr style="background:#141129;"><td style="padding:10px; color:#e2e8f0;">3</td><td style="padding:10px; color:#e2e8f0;">Recargo</td><td style="padding:10px; color:#c4b5fd;">1.50</td></tr>
      <tr><td style="padding:10px; color:#e2e8f0;">4</td><td style="padding:10px; color:#e2e8f0;">Interes</td><td style="padding:10px; color:#c4b5fd;">0.3333333333</td></tr>
    </tbody>
  </table>
  </div>

  <div style="background:#1a1730; border-left:4px solid #a78bfa; padding:14px 18px; border-radius:8px; margin-top:14px; font-size:0.9em; color:#e9d5ff;">
    Sin argumentos, cada valor conserva exactamente los decimales con que se escribió: <strong style="color:#c4b5fd;">no hay redondeo ni relleno con ceros</strong>.
  </div>
</div>

<!-- ERRORES Y BUENAS PRACTICAS -->
<h2 style="display:flex; align-items:center; gap:12px; color:#f1f5f9; font-size:1.5em; margin: 36px 0 16px 0;">
  <span style="display:inline-block; width:8px; height:28px; background: linear-gradient(180deg,#ef4444,#10b981); border-radius:4px; box-shadow: 0 0 20px rgba(239,68,68,0.6);"></span>
  Errores y buenas prácticas
</h2>

<div style="display:grid; gap:12px;">
  <div style="background: linear-gradient(90deg,#2a0a0a,#3f0f0f); border-left:5px solid #ef4444; border-radius:12px; padding:16px 20px; box-shadow: 0 6px 20px -12px rgba(239,68,68,0.8); border: 1px solid rgba(239,68,68,0.25); border-left-width: 5px;">
    <span style="background: linear-gradient(135deg,#ef4444,#991b1b); color:white; padding:3px 12px; border-radius:999px; font-size:0.75em; font-weight:800; letter-spacing:1px; box-shadow:0 0 12px rgba(239,68,68,0.6);">ERROR</span>
    <span style="margin-left:10px; color:#fecaca; font-size:0.93em;">Guardar dinero en <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">REAL</code> o <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">DOUBLE PRECISION</code>. No hay mensaje de error: los totales salen con diferencias minúsculas porque <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">0.1</code> no tiene representación binaria exacta.</span>
  </div>
  <div style="background: linear-gradient(90deg,#2a0a0a,#3f0f0f); border-left:5px solid #ef4444; border-radius:12px; padding:16px 20px; box-shadow: 0 6px 20px -12px rgba(239,68,68,0.8); border: 1px solid rgba(239,68,68,0.25); border-left-width: 5px;">
    <span style="background: linear-gradient(135deg,#ef4444,#991b1b); color:white; padding:3px 12px; border-radius:999px; font-size:0.75em; font-weight:800; letter-spacing:1px; box-shadow:0 0 12px rgba(239,68,68,0.6);">ERROR</span>
    <span style="margin-left:10px; color:#fecaca; font-size:0.93em;"><code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">numeric field overflow</code>: la parte entera supera <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">precision − escala</code> dígitos; en <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">NUMERIC(5,2)</code> solo caben 3 enteros.</span>
  </div>
  <div style="background: linear-gradient(90deg,#2a0a0a,#3f0f0f); border-left:5px solid #ef4444; border-radius:12px; padding:16px 20px; box-shadow: 0 6px 20px -12px rgba(239,68,68,0.8); border: 1px solid rgba(239,68,68,0.25); border-left-width: 5px;">
    <span style="background: linear-gradient(135deg,#ef4444,#991b1b); color:white; padding:3px 12px; border-radius:999px; font-size:0.75em; font-weight:800; letter-spacing:1px; box-shadow:0 0 12px rgba(239,68,68,0.6);">ERROR</span>
    <span style="margin-left:10px; color:#fecaca; font-size:0.93em;">Declarar <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">NUMERIC(10)</code> y esperar decimales: sin escala equivale a <code style="background:#7f1d1d; color:#fecaca; padding:2px 6px; border-radius:4px;">NUMERIC(10,0)</code> y todo se redondea a entero.</span>
  </div>
  <div style="background: linear-gradient(90deg,#042a1f,#064e3b); border-left:5px solid #10b981; border-radius:12px; padding:16px 20px; box-shadow: 0 6px 20px -12px rgba(16,185,129,0.8); border: 1px solid rgba(16,185,129,0.25); border-left-width: 5px;">
    <span style="background: linear-gradient(135deg,#10b981,#047857); color:white; padding:3px 12px; border-radius:999px; font-size:0.75em; font-weight:800; letter-spacing:1px; box-shadow:0 0 12px rgba(16,185,129,0.6);">BUENA PRÁCTICA</span>
    <span style="margin-left:10px; color:#d1fae5; font-size:0.93em;">Usar <code style="background:#065f46; color:#d1fae5; padding:2px 6px; border-radius:4px;">NUMERIC(p,s)</code> para precios, saldos e impuestos, y <code style="background:#065f46; color:#d1fae5; padding:2px 6px; border-radius:4px;">DOUBLE PRECISION</code> para mediciones donde la aproximación es aceptable.</span>
  </div>
  <div style="background: linear-gradient(90deg,#042a1f,#064e3b); border-left:5px solid #10b981; border-radius:12px; padding:16px 20px; box-shadow: 0 6px 20px -12px rgba(16,185,129,0.8); border: 1px solid rgba(16,185,129,0.25); border-left-width: 5px;">
    <span style="background: linear-gradient(135deg,#10b981,#047857); color:white; padding:3px 12px; border-radius:999px; font-size:0.75em; font-weight:800; letter-spacing:1px; box-shadow:0 0 12px rgba(16,185,129,0.6);">BUENA PRÁCTICA</span>
    <span style="margin-left:10px; color:#d1fae5; font-size:0.93em;">Calcular <code style="background:#065f46; color:#d1fae5; padding:2px 6px; border-radius:4px;">precision</code> y <code style="background:#065f46; color:#d1fae5; padding:2px 6px; border-radius:4px;">escala</code> con el valor máximo real del negocio más un margen; evitar <code style="background:#065f46; color:#d1fae5; padding:2px 6px; border-radius:4px;">REAL</code> salvo que el espacio sea crítico.</span>
  </div>
</div>

<!-- FOOTER -->
<div style="margin-top:32px; padding:18px; text-align:center; border-radius:14px; background: linear-gradient(90deg,#0f0c29,#302b63,#6d28d9); color:#e9d5ff; font-size:0.85em; letter-spacing:1.5px; font-weight:700; box-shadow: 0 10px 30px -14px rgba(109,40,217,0.7); border: 1px solid rgba(139,92,246,0.35);">
  FIN DE LA CLASE 005 · NUMERIC · REAL · DOUBLE PRECISION
</div>

</div>
