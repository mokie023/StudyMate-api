const entries = [
  { id: 1, title: 'Week Reflection', mood: 'Focused' },
  { id: 2, title: 'Project Planning', mood: 'Motivated' },
]

export default function Journals() {
  return (
    <section className="page">
      <h1>Journals</h1>
      <div className="stack">
        {entries.map((entry) => (
          <article className="card" key={entry.id}>
            <h3>{entry.title}</h3>
            <p className="muted">Mood: {entry.mood}</p>
          </article>
        ))}
      </div>
    </section>
  )
}
