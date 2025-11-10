Cargo Management System (Dynamic Dashboard)

Instructions:
1. Import the SQL file into your MySQL server:
   - Use MySQL Workbench or phpMyAdmin to import database/cargomanagementsystem.sql
2. Start backend:
   cd backend
   npm install
   node server.js
3. Open frontend/index.html with Live Server (VS Code) or open file in browser.

Notes:
- The backend reads DB credentials from backend/.env (pre-filled).
- API endpoints:
  GET /api/<table>           -> fetch all rows
  GET /api/meta/<table>      -> get column info and primary key
  POST /api/<table>          -> insert row (JSON body with keys)
  DELETE /api/<table>/:id    -> delete row by primary key
