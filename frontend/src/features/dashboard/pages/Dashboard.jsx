const metrics = [
  { label: 'Open Tasks', value: '08' },
  { label: 'Notes This Week', value: '14' },
  { label: 'Journal Streak', value: '5 days' },
]

export default function Dashboard() {
  return (
    <section className="page">
      <h1>Dashboard</h1>
      <p className="muted">A quick snapshot of your academic momentum.</p>
      <div className="stat-grid">
        {metrics.map((item) => (
          <article key={item.label} className="card stat-card">
            <div className="stat-value">{item.value}</div>
            <div className="muted">{item.label}</div>
          </article>
        ))}
      </div>
    </section>
  )
}
