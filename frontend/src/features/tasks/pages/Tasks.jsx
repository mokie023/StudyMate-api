const sampleTasks = [
  { id: 1, title: 'Finish DB assignment', due: 'Tomorrow' },
  { id: 2, title: 'Read Chapter 4', due: 'Friday' },
]

export default function Tasks() {
  return (
    <section className="page">
      <h1>Tasks</h1>
      <div className="stack">
        {sampleTasks.map((task) => (
          <article className="card" key={task.id}>
            <h3>{task.title}</h3>
            <p className="muted">Due: {task.due}</p>
          </article>
        ))}
      </div>
    </section>
  )
}
