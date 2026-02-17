import { createBrowserRouter, Link } from 'react-router-dom'
import App from './App'
import Login from '../features/auth/pages/Login'
import Register from '../features/auth/pages/Register'
import Dashboard from '../features/dashboard/pages/Dashboard'
import NotesList from '../features/notes/pages/NotesList'
import AddNote from '../features/notes/pages/AddNote'
import ViewNote from '../features/notes/pages/ViewNote'
import Folders from '../features/notes/pages/Folders'
import Tasks from '../features/tasks/pages/Tasks'
import Journals from '../features/journals/pages/Journals'

const Landing = () => (
  <section className="page page-hero">
    <div className="hero-kicker">StudentAcademicToolkit</div>
    <h1>Organize your study life in one workflow</h1>
    <p>
      Capture notes, track tasks, and maintain reflective journals across one unified app.
    </p>
    <div className="hero-actions">
      <Link className="btn btn-primary" to="/register">Get Started</Link>
      <Link className="btn btn-ghost" to="/login">Sign In</Link>
    </div>
  </section>
)

const router = createBrowserRouter([
  {
    path: '/',
    element: <App />,
    children: [
      { index: true, element: <Landing /> },
      { path: 'login', element: <Login /> },
      { path: 'register', element: <Register /> },
      { path: 'dashboard', element: <Dashboard /> },
      { path: 'notes', element: <NotesList /> },
      { path: 'notes/new', element: <AddNote /> },
      { path: 'notes/:id', element: <ViewNote /> },
      { path: 'folders', element: <Folders /> },
      { path: 'tasks', element: <Tasks /> },
      { path: 'journals', element: <Journals /> },
    ],
  },
])

export default router
