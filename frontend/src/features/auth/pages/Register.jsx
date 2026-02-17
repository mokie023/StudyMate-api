export default function Register() {
  return (
    <section className="page">
      <div className="card auth-card">
        <h2>Create Account</h2>
        <p className="muted">Start your academic command center in under a minute.</p>
        <form className="form-grid">
          <label>
            Full Name
            <input className="input" type="text" placeholder="Jane Student" />
          </label>
          <label>
            Email
            <input className="input" type="email" placeholder="you@example.com" />
          </label>
          <label>
            Password
            <input className="input" type="password" placeholder="Create a strong password" />
          </label>
          <button className="btn btn-primary" type="button">Create Account</button>
        </form>
      </div>
    </section>
  )
}
