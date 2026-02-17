import { useParams } from 'react-router-dom'

export default function ViewNote() {
  const { id } = useParams()

  return (
    <section className="page">
      <article className="card">
        <h1>Note #{id}</h1>
        <p className="muted">Detailed note content will render here from API.</p>
      </article>
    </section>
  )
}
