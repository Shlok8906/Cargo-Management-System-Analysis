from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)

#Database Connection
def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="shlok@8906",
        database="cargomanagementsystem"
    )

#Helper: Check if table has column
def table_has_column(cursor, table, column):
    cursor.execute(f"SHOW COLUMNS FROM `{table}` LIKE %s", (column,))
    return len(cursor.fetchall()) > 0


# 🔹 Meta Info (table columns + primary key)
@app.route("/api/meta/<table>", methods=["GET"])
def get_meta(table):
    try:
        db = get_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute(f"DESCRIBE `{table}`")
        rows = cursor.fetchall()
        pk = next((r["Field"] for r in rows if r["Key"] == "PRI"), None)
        cursor.close()
        db.close()
        return jsonify({"columns": rows, "primaryKey": pk})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


#UNIVERSAL SMART SEARCH
@app.route("/api/search", methods=["GET"])
def smart_search():
    client_id = request.args.get("client_id")
    cargo_id = request.args.get("cargo_id")
    shipment_id = request.args.get("shipment_id")

    if not client_id and not cargo_id and not shipment_id:
        return jsonify({"error": "Please provide client_id, cargo_id, or shipment_id"}), 400

    try:
        db = get_db()
        cursor = db.cursor(dictionary=True)

        data = {
            "foundIn": None,
            "client": None,
            "cargos": [],
            "shipments": [],
            "trackinglogs": [],
            "vehicles": [],
            "warehouses": [],
            "warehousestorage": [],
            "customs": [],
            "payments": [],
            "insuranceclaims": [],
            "employees": [],
            "routes": []
        }

        def safe_query(table, column, ids):
            if not ids:
                return []
            if not table_has_column(cursor, table, column):
                return []
            placeholders = ", ".join(["%s"] * len(ids))
            cursor.execute(f"SELECT * FROM `{table}` WHERE `{column}` IN ({placeholders})", ids)
            return cursor.fetchall()

        # 🔹 CLIENT SEARCH
        if client_id:
            cursor.execute("SELECT * FROM clients WHERE client_id = %s", (client_id,))
            client = cursor.fetchall()
            if not client:
                return jsonify({"error": "Invalid client_id"}), 404
            data["client"] = client[0]

            cursor.execute("SELECT * FROM cargo WHERE client_id = %s", (client_id,))
            cargos = cursor.fetchall()
            data["cargos"] = cargos
            cargo_ids = [c["cargo_id"] for c in cargos]

            data["shipments"] = safe_query("shipments", "cargo_id", cargo_ids)
            shipment_ids = [s["shipment_id"] for s in data["shipments"]]
            vehicle_ids = [s["vehicle_id"] for s in data["shipments"]]

            data["trackinglogs"] = safe_query("trackinglogs", "shipment_id", shipment_ids)
            data["vehicles"] = safe_query("vehicles", "vehicle_id", vehicle_ids)
            data["warehousestorage"] = safe_query("warehousestorage", "cargo_id", cargo_ids)
            data["customs"] = safe_query("customs", "cargo_id", cargo_ids)
            data["payments"] = safe_query("payments", "cargo_id", cargo_ids)
            data["insuranceclaims"] = safe_query("insuranceclaims", "cargo_id", cargo_ids)
            data["routes"] = safe_query("routes", "cargo_id", cargo_ids)

            data["foundIn"] = "client"
            data["message"] = f"✅ Found full details for client_id: {client_id}"

        # 🔹 CARGO SEARCH
        elif cargo_id:
            cursor.execute("SELECT * FROM cargo WHERE cargo_id = %s", (cargo_id,))
            cargo = cursor.fetchall()
            if not cargo:
                return jsonify({"error": "❌ Invalid cargo_id"}), 404
            data["cargos"] = cargo

            cursor.execute("SELECT * FROM clients WHERE client_id = %s", (cargo[0]["client_id"],))
            client = cursor.fetchall()
            data["client"] = client[0]

            cursor.execute("SELECT * FROM shipments WHERE cargo_id = %s", (cargo_id,))
            shipments = cursor.fetchall()
            data["shipments"] = shipments
            shipment_ids = [s["shipment_id"] for s in shipments]
            vehicle_ids = [s["vehicle_id"] for s in shipments]

            data["trackinglogs"] = safe_query("trackinglogs", "shipment_id", shipment_ids)
            data["vehicles"] = safe_query("vehicles", "vehicle_id", vehicle_ids)
            data["warehousestorage"] = safe_query("warehousestorage", "cargo_id", [cargo_id])
            data["customs"] = safe_query("customs", "cargo_id", [cargo_id])
            data["payments"] = safe_query("payments", "cargo_id", [cargo_id])
            data["insuranceclaims"] = safe_query("insuranceclaims", "cargo_id", [cargo_id])
            data["routes"] = safe_query("routes", "cargo_id", [cargo_id])

            data["foundIn"] = "cargo"
            data["message"] = f"✅ Found full details for cargo_id: {cargo_id}"

        # 🔹 SHIPMENT SEARCH
        elif shipment_id:
            cursor.execute("SELECT * FROM shipments WHERE shipment_id = %s", (shipment_id,))
            shipment = cursor.fetchall()
            if not shipment:
                return jsonify({"error": "❌ Invalid shipment_id"}), 404
            data["shipments"] = shipment

            cargo_id = shipment[0]["cargo_id"]
            vehicle_id = shipment[0]["vehicle_id"]

            cursor.execute("SELECT * FROM cargo WHERE cargo_id = %s", (cargo_id,))
            cargo = cursor.fetchall()
            cursor.execute("SELECT * FROM clients WHERE client_id = %s", (cargo[0]["client_id"],))
            client = cursor.fetchall()
            data["cargos"] = cargo
            data["client"] = client[0]

            cursor.execute("SELECT * FROM trackinglogs WHERE shipment_id = %s", (shipment_id,))
            data["trackinglogs"] = cursor.fetchall()
            cursor.execute("SELECT * FROM vehicles WHERE vehicle_id = %s", (vehicle_id,))
            data["vehicles"] = cursor.fetchall()

            data["warehousestorage"] = safe_query("warehousestorage", "cargo_id", [cargo_id])
            data["customs"] = safe_query("customs", "cargo_id", [cargo_id])
            data["payments"] = safe_query("payments", "cargo_id", [cargo_id])
            data["insuranceclaims"] = safe_query("insuranceclaims", "cargo_id", [cargo_id])
            data["routes"] = safe_query("routes", "cargo_id", [cargo_id])

            data["foundIn"] = "shipment"
            data["message"] = f"✅ Found full details for shipment_id: {shipment_id}"

        cursor.close()
        db.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


#Get all records
@app.route("/api/<table>", methods=["GET"])
def get_all(table):
    try:
        db = get_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute(f"SELECT * FROM `{table}`")
        rows = cursor.fetchall()
        cursor.close()
        db.close()
        return jsonify(rows)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Add new record
@app.route("/api/<table>", methods=["POST"])
def add_record(table):
    try:
        data = request.json or {}
        if not data:
            return jsonify({"error": "No data provided"}), 400

        cols = ", ".join([f"`{k}`" for k in data.keys()])
        placeholders = ", ".join(["%s"] * len(data))
        values = tuple(data.values())

        db = get_db()
        cursor = db.cursor()
        cursor.execute(f"INSERT INTO `{table}` ({cols}) VALUES ({placeholders})", values)
        db.commit()
        inserted_id = cursor.lastrowid
        cursor.close()
        db.close()

        return jsonify({"insertedId": inserted_id, "message": "✅ Record inserted successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


#Update record
@app.route("/api/<table>/<int:id>", methods=["PUT"])
def update_record(table, id):
    try:
        data = request.json or {}
        db = get_db()
        cursor = db.cursor(dictionary=True)

        cursor.execute(f"DESCRIBE `{table}`")
        cols = cursor.fetchall()
        pk = next((r["Field"] for r in cols if r["Key"] == "PRI"), None)
        if not pk:
            return jsonify({"error": "Primary key not found"}), 400

        updates = ", ".join([f"`{k}` = %s" for k in data.keys()])
        values = list(data.values()) + [id]
        cursor.execute(f"UPDATE `{table}` SET {updates} WHERE `{pk}` = %s", values)
        db.commit()
        cursor.close()
        db.close()

        return jsonify({"message": "✅ Record updated successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


#Delete record
@app.route("/api/<table>/<int:id>", methods=["DELETE"])
def delete_record(table, id):
    try:
        db = get_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute(f"DESCRIBE `{table}`")
        cols = cursor.fetchall()
        pk = next((r["Field"] for r in cols if r["Key"] == "PRI"), None)
        if not pk:
            return jsonify({"error": "Primary key not found"}), 400

        cursor.execute(f"DELETE FROM `{table}` WHERE `{pk}` = %s", (id,))
        db.commit()
        cursor.close()
        db.close()
        return jsonify({"message": "✅ Record deleted successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route("/api/cargo/status/<status>", methods=["GET"])
def filter_cargo_status(status):
    allowed_status = ["In Transit", "Delayed","Pending"]
    if status not in allowed_status:
        return jsonify({"error": f"Invalid status. Allowed: {', '.join(allowed_status)}"}), 400

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM shipments WHERE status = %s", (status,))
        rows = cursor.fetchall()
        if not rows:
            return jsonify({"message": f"No cargos found with status '{status}'"}), 404
        return jsonify({
            "count": len(rows),
            "status": status,
            "cargos": rows,
            "message": f"✅ Found {len(rows)} cargos with status '{status}'"
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        conn.close()

#Run Server
if __name__ == "__main__":
    app.run(debug=True, port=5000)
