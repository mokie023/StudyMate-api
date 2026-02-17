import { Outlet } from 'react-router-dom'
import Navbar from '../components/Navbar'

export default function App() {
  return (
    <div className="app-shell">
      <div className="app-glow app-glow-left" aria-hidden="true" />
      <div className="app-glow app-glow-right" aria-hidden="true" />
      <Navbar />
      <main className="app-main">
        <Outlet />
      </main>
    </div>
  )
}
