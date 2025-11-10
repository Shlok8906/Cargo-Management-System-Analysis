// ✅ API base (use 127.0.0.1 to avoid CORS issues)
const API_BASE = "http://127.0.0.1:5000/api";

const tables = [
  'cargo','clients','customs','employees','insuranceclaims','payments',
  'routes','shipments','trackinglogs','vehicles','warehouses','warehousestorage'
];

const tableListEl = document.getElementById('tableList');
const tableContainer = document.getElementById('tableContainer');
const controls = document.getElementById('controls');
const currentTableLabel = document.getElementById('currentTableLabel');
const reloadBtn = document.getElementById('reloadBtn');

// 🧩 Message utility
function showMessage(msg, type = 'info', duration = 4000) {
  let oldMsg = document.querySelector('.message-box');
  if (oldMsg) oldMsg.remove();
  const box = document.createElement('div');
  box.className = `message-box ${type}`;
  box.textContent = msg;
  document.body.appendChild(box);
  setTimeout(() => box.remove(), duration);
}

// 🧭 Sidebar
function renderTableList() {
  tableListEl.innerHTML = '';
  tables.forEach(t => {
    const li = document.createElement('li');
    li.textContent = t;
    li.onclick = () => loadTable(t);
    tableListEl.appendChild(li);
  });
}

// 📋 Load table data
async function loadTable(table) {
  currentTableLabel.textContent = `Showing: ${table}`;
  tableContainer.innerHTML = 'Loading...';
  controls.innerHTML = '';

  try {
    const metaRes = await fetch(`${API_BASE}/meta/${table}`);
    if (!metaRes.ok) throw new Error(`Meta fetch failed (${metaRes.status})`);
    const meta = await metaRes.json();
    const cols = meta.columns;
    const pk = meta.primaryKey;

    const addBtn = document.createElement('button');
    addBtn.className = 'btn';
    addBtn.textContent = '➕ Add New';
    addBtn.onclick = () => showAddForm(table, cols, pk);
    controls.appendChild(addBtn);

    const res = await fetch(`${API_BASE}/${table}`);
    if (!res.ok) throw new Error(`Data fetch failed (${res.status})`);
    const data = await res.json();

    if (!Array.isArray(data) || data.length === 0) {
      tableContainer.innerHTML = '<p>No rows found.</p>';
      return;
    }

    let html = '<table><thead><tr>';
    cols.forEach(c => html += `<th>${c.Field}</th>`);
    html += '<th>Actions</th></tr></thead><tbody>';

    data.forEach(row => {
      html += '<tr>';
      cols.forEach(c => {
        let v = row[c.Field];
        if (v === null || v === undefined) v = '';
        html += `<td>${v}</td>`;
      });
      const id = pk ? row[pk] : '';
      html += `<td>
  ${pk ? `
    <button class="btn" onclick="showUpdateForm('${table}', '${id}')">Update</button>
    <button class="btn danger" onclick="deleteRow('${table}', '${id}')">Delete</button>
  ` : ''}
</td>`;
async function showUpdateForm(table, id) {
  controls.innerHTML = '';
  const resMeta = await fetch(`${API_BASE}/meta/${table}`);
  const meta = await resMeta.json();
  const cols = meta.columns;
  const pk = meta.primaryKey;

  // Fetch existing data for this record
  const resData = await fetch(`${API_BASE}/${table}`);
  const allData = await resData.json();
  const record = allData.find(row => row[pk] == id);
  if (!record) return showMessage('⚠️ Record not found', 'error');

  const form = document.createElement('form');
  cols.forEach(c => {
    if (c.Extra && c.Extra.includes('auto_increment')) return;

    const row = document.createElement('div');
    row.className = 'form-row';
    const label = document.createElement('label');
    label.textContent = `${c.Field}: `;
    row.appendChild(label);

    const input = document.createElement('input');
    input.name = c.Field;
    input.value = record[c.Field] ?? '';
    if (c.Type.includes('int') || c.Type.includes('float') || c.Type.includes('decimal'))
      input.type = 'number';
    else if (c.Type.includes('datetime'))
      input.type = 'datetime-local';
    else
      input.type = 'text';

    row.appendChild(input);
    form.appendChild(row);
  });

  const saveBtn = document.createElement('button');
  saveBtn.className = 'btn';
  saveBtn.textContent = 'Update';
  saveBtn.type = 'submit';

  const cancelBtn = document.createElement('button');
  cancelBtn.type = 'button';
  cancelBtn.textContent = 'Cancel';
  cancelBtn.onclick = () => { controls.innerHTML = ''; loadTable(table); };

  form.appendChild(saveBtn);
  form.appendChild(cancelBtn);
  controls.appendChild(form);

  // 🧠 Submit logic for update
  form.onsubmit = async e => {
    e.preventDefault();
    const formData = {};
    cols.forEach(c => {
      if (c.Extra && c.Extra.includes('auto_increment')) return;
      const input = form.querySelector(`[name="${c.Field}"]`);
      if (!input) return;
      let val = input.value.trim();
      if (val === '') val = null;
      formData[c.Field] = val;
    });

    try {
      const resp = await fetch(`${API_BASE}/${table}/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });
      const j = await resp.json();
      if (!resp.ok || j.error) throw new Error(j.error || 'Update failed');
      showMessage('✅ Record updated successfully!', 'success');
      controls.innerHTML = '';
      loadTable(table);
    } catch (err) {
      console.error(err);
      showMessage(`❌ Update failed: ${err.message}`, 'error', 6000);
    }
  };
}


      html += '</tr>';
    });

    html += '</tbody></table>';
    tableContainer.innerHTML = html;
  } catch (err) {
    console.error(err);
    showMessage(`⚠️ Error loading ${table}: ${err.message}`, 'error', 6000);
    tableContainer.innerHTML = `<p style="color:red;">Failed to load table: ${err.message}</p>`;
  }
}

// 📝 Add new record
function showAddForm(table, cols, pk) {
  controls.innerHTML = '';
  const form = document.createElement('form');

  const predefinedDropdowns = {
    status: ['Pending', 'In Transit', 'Delivered', 'Cancelled'],
    gender: ['Male', 'Female', 'Other'],
    payment_status: ['Paid', 'Unpaid', 'Pending'],
    role: ['Manager', 'Driver', 'Admin', 'Clerk']
  };

  cols.forEach(c => {
    if (c.Extra && c.Extra.includes('auto_increment')) return;

    const row = document.createElement('div');
    row.className = 'form-row';

    const label = document.createElement('label');
    label.textContent = `${c.Field}: `;
    row.appendChild(label);

    let input;

    if (c.Type.startsWith('enum(')) {
      const values = c.Type.match(/'(.*?)'/g)?.map(v => v.replace(/'/g, '')) || [];
      input = document.createElement('select');
      values.forEach(v => {
        const opt = document.createElement('option');
        opt.value = v;
        opt.textContent = v;
        input.appendChild(opt);
      });
    } else if (predefinedDropdowns[c.Field]) {
      input = document.createElement('select');
      predefinedDropdowns[c.Field].forEach(optVal => {
        const opt = document.createElement('option');
        opt.value = optVal;
        opt.textContent = optVal;
        input.appendChild(opt);
      });
    } else {
      input = document.createElement('input');
      input.name = c.Field;
      if (c.Type.includes('int') || c.Type.includes('float') || c.Type.includes('decimal'))
        input.type = 'number';
      else if (c.Type.includes('datetime'))
        input.type = 'datetime-local';
      else
        input.type = 'text';
    }

    input.name = c.Field;
    row.appendChild(input);
    form.appendChild(row);
  });

  const submit = document.createElement('button');
  submit.className = 'btn';
  submit.type = 'submit';
  submit.textContent = 'Save';

  const cancel = document.createElement('button');
  cancel.type = 'button';
  cancel.textContent = 'Cancel';
  cancel.onclick = () => { controls.innerHTML = ''; loadTable(table); };

  form.appendChild(submit);
  form.appendChild(cancel);
  controls.appendChild(form);

  form.onsubmit = async e => {
    e.preventDefault();
    const formData = {};
    cols.forEach(c => {
      if (c.Extra && c.Extra.includes('auto_increment')) return;
      const input = form.querySelector(`[name="${c.Field}"]`);
      if (!input) return;
      let val = input.value.trim();
      if (val === '') val = null;
      formData[c.Field] = val;
    });

    try {
      const resp = await fetch(`${API_BASE}/${table}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });
      const j = await resp.json();
      if (!resp.ok || j.error) throw new Error(j.error || 'Insert failed');
      showMessage(`✅ Record added successfully!`, 'success');
      controls.innerHTML = '';
      loadTable(table);
    } catch (err) {
      console.error(err);
      showMessage(`❌ Insert failed: ${err.message}`, 'error', 6000);
    }
  };
}

// 🔄 Sidebar reload
reloadBtn.onclick = () => renderTableList();
renderTableList();

// 🧠 Build Search Results Display
function buildSearchResultHTML(data) {
  if (!data || data.error) {
    return `<div class="alert alert-danger">${data?.error || "❌ No data found"}</div>`;
  }

  let html = `<div class="alert alert-success">${data.message}</div>`;

  const addTable = (title, rows) => {
    if (!rows || rows.length === 0) return "";
    const keys = Object.keys(rows[0]);
    return `
      <h4 class="mt-3">${title}</h4>
      <table class="table table-bordered table-sm">
        <thead><tr>${keys.map(k => `<th>${k}</th>`).join('')}</tr></thead>
        <tbody>${rows.map(r => `<tr>${keys.map(k => `<td>${r[k]}</td>`).join('')}</tr>`).join('')}</tbody>
      </table>`;
  };

  if (data.client) html += addTable("👤 Client Info", [data.client]);
  if (data.cargos?.length) html += addTable("📦 Cargo", data.cargos);
  if (data.shipments?.length) html += addTable("🚚 Shipments", data.shipments);
  if (data.trackinglogs?.length) html += addTable("📍 Tracking Logs", data.trackinglogs);
  if (data.vehicles?.length) html += addTable("🚗 Vehicles", data.vehicles);
  if (data.warehouses?.length) html += addTable("🏭 Warehouses", data.warehouses);
  if (data.warehousestorage?.length) html += addTable("📦 Warehouse Storage", data.warehousestorage);
  if (data.customs?.length) html += addTable("🧾 Customs", data.customs);
  if (data.payments?.length) html += addTable("💰 Payments", data.payments);
  if (data.insuranceclaims?.length) html += addTable("🧮 Insurance Claims", data.insuranceclaims);
  if (data.routes?.length) html += addTable("🗺️ Routes", data.routes);
  if (data.employees?.length) html += addTable("👷 Employees", data.employees);

  return html;
}

// 🔍 Unified Search
document.getElementById("searchBtn").addEventListener("click", async () => {
  const id = document.getElementById("searchInput").value.trim();
  const type = document.getElementById("searchType").value;
  const resultDiv = document.getElementById("searchResults");

  if (!id) {
    resultDiv.innerHTML = `<div class="alert alert-warning">⚠️ Please enter an ID.</div>`;
    return;
  }

  resultDiv.innerHTML = `<div class="alert alert-info">⏳ Searching...</div>`;

  try {
    const res = await fetch(`${API_BASE}/search?${type}=${id}`);
    const data = await res.json();

    if (!res.ok) {
      resultDiv.innerHTML = `<div class="alert alert-danger">❌ ${data.error || "Search failed"}</div>`;
    } else {
      resultDiv.innerHTML = buildSearchResultHTML(data);
      showMessage('✅ Data loaded successfully', 'success');
    }
  } catch (err) {
    resultDiv.innerHTML = `<div class="alert alert-danger">⚠️ Failed: ${err.message}</div>`;
  }
});

// 🗑️ Delete record
async function deleteRow(table, id) {
  if (!confirm(`Are you sure you want to delete record ${id} from ${table}?`)) return;

  try {
    const res = await fetch(`${API_BASE}/${table}/${id}`, { method: "DELETE" });
    const data = await res.json();

    if (!res.ok) throw new Error(data.error || "Delete failed");

    showMessage("✅ Record deleted successfully!", "success");
    loadTable(table); // reload table
  } catch (err) {
    console.error("Delete error:", err);
    showMessage(`❌ Delete failed: ${err.message}`, "error", 6000);
  }
}

window.showUpdateForm = async function (table, id) {
  controls.innerHTML = '';
  try {
    // 🧩 Fetch table structure
    const resMeta = await fetch(`${API_BASE}/meta/${table}`);
    const meta = await resMeta.json();
    const cols = meta.columns;
    const pk = meta.primaryKey;

    // 🧩 Fetch existing row data
    const resData = await fetch(`${API_BASE}/${table}`);
    const allData = await resData.json();
    const record = allData.find(row => String(row[pk]) === String(id));
    if (!record) return showMessage('⚠️ Record not found', 'error');

    // 🧱 Build update form
    const form = document.createElement('form');
    cols.forEach(c => {
      if (c.Extra && c.Extra.includes('auto_increment')) return;

      const row = document.createElement('div');
      row.className = 'form-row';
      const label = document.createElement('label');
      label.textContent = `${c.Field}: `;
      row.appendChild(label);

      const input = document.createElement('input');
      input.name = c.Field;
      input.value = record[c.Field] ?? '';
      if (c.Type.includes('int') || c.Type.includes('float') || c.Type.includes('decimal'))
        input.type = 'number';
      else if (c.Type.includes('datetime'))
        input.type = 'datetime-local';
      else
        input.type = 'text';
      
      row.appendChild(input);
      form.appendChild(row);
    });

    const saveBtn = document.createElement('button');
    saveBtn.className = 'btn';
    saveBtn.textContent = 'Update';
    saveBtn.type = 'submit';

    const cancelBtn = document.createElement('button');
    cancelBtn.type = 'button';
    cancelBtn.textContent = 'Cancel';
    cancelBtn.onclick = () => { controls.innerHTML = ''; loadTable(table); };

    form.appendChild(saveBtn);
    form.appendChild(cancelBtn);
    controls.appendChild(form);

    // 🧠 Submit logic
    form.onsubmit = async e => {
      e.preventDefault();
      const formData = {};
      cols.forEach(c => {
        if (c.Extra && c.Extra.includes('auto_increment')) return;
        const input = form.querySelector(`[name="${c.Field}"]`);
        if (!input) return;
        let val = input.value.trim();
        if (val === '') val = null;
        formData[c.Field] = val;
      });

      try {
        const resp = await fetch(`${API_BASE}/${table}/${id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        const j = await resp.json();
        if (!resp.ok || j.error) throw new Error(j.error || 'Update failed');
        showMessage('✅ Record updated successfully!', 'success');
        controls.innerHTML = '';
        loadTable(table);
      } catch (err) {
        console.error(err);
        showMessage(`❌ Update failed: ${err.message}`, 'error', 6000);
      }
    };
  } catch (err) {
    console.error('Error loading update form:', err);
    showMessage(`❌ Failed to load update form: ${err.message}`, 'error');
  }
};
async function filterCargos() {
  const status = document.getElementById("cargoStatus").value;
  const resultsDiv = document.getElementById("statusResults");

  if (!status) {
    resultsDiv.innerHTML = `<div class="message-box info">⚠️ Please select a status.</div>`;
    return;
  }

  try {
    const res = await fetch(`${API_BASE}/cargo/status/${encodeURIComponent(status)}`);
    const data = await res.json();

    if (!res.ok || data.error) {
      resultsDiv.innerHTML = `<div class="message-box error">${data.error || "Error fetching cargos"}</div>`;
      return;
    }

    if (!data.cargos || data.cargos.length === 0) {
      resultsDiv.innerHTML = `<div class="message-box info">${data.message}</div>`;
      return;
    }

    let html = `
      <h4>${data.message}</h4>
      <table>
        <thead><tr>${Object.keys(data.cargos[0]).map(c => `<th>${c}</th>`).join('')}</tr></thead>
        <tbody>
          ${data.cargos.map(r => `<tr>${Object.values(r).map(v => `<td>${v}</td>`).join('')}</tr>`).join('')}
        </tbody>
      </table>
    `;
    resultsDiv.innerHTML = html;
  } catch (err) {
    resultsDiv.innerHTML = `<div class="message-box error">❌ ${err.message}</div>`;
  }
}
