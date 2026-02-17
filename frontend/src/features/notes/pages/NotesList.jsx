import { Link } from 'react-router-dom'

const sampleNotes = [
  { id: 1, title: 'Data Structures - Trees', excerpt: 'Balancing BSTs and traversal strategies.' },
  { id: 2, title: 'Operating Systems', excerpt: 'Process scheduling and context switching.' },
]

export default function NotesList() {
  return (
    <section className="page">
      <div className="page-header">
        <h1>Notes</h1>
        <Link className="btn btn-primary" to="/notes/new">Add Note</Link>
      </div>
      <div className="stack">
        {sampleNotes.map((note) => (
          <article className="card" key={note.id}>
            <h3>{note.title}</h3>
            <p className="muted">{note.excerpt}</p>
            <Link className="inline-link" to={`/notes/${note.id}`}>Open Note</Link>
          </article>
        ))}
      </div>
    </section>
  )
}
