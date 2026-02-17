export default function AddNote() {
  return (
    <section className="page">
      <div className="card">
        <h1>Create Note</h1>
        <form className="form-grid">
          <label>
            Title
            <input className="input" type="text" placeholder="e.g. Linear Algebra" />
          </label>
          <label>
            Content
            <textarea className="input" rows="6" placeholder="Write your note content..." />
          </label>
          <button className="btn btn-primary" type="button">Save Note</button>
        </form>
      </div>
    </section>
  )
}
