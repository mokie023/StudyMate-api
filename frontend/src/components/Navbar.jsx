import { NavLink, useNavigate } from 'react-router-dom'

export default function Navbar() {
  const navigate = useNavigate()

  const handleLogout = () => {
    localStorage.removeItem('token')
    navigate('/login')
  }

  return (
    <header className="topbar">
      <div className="topbar-inner">
        <NavLink className="brand" to="/dashboard">StudyMate</NavLink>
        <nav className="topnav">
          <NavLink className="topnav-link" to="/dashboard">Dashboard</NavLink>
          <NavLink className="topnav-link" to="/notes">Notes</NavLink>
          <NavLink className="topnav-link" to="/tasks">Tasks</NavLink>
          <NavLink className="topnav-link" to="/journals">Journals</NavLink>
        </nav>
        <button className="btn btn-ghost" onClick={handleLogout} type="button">Logout</button>
      </div>
    </header>
  )
}
