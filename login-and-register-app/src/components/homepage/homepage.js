import React from "react"
import "./homepage.css"
import { useLocation } from "react-router"

const Homepage = ({ setLoginUser }) => {
    const { state } = useLocation()

    return (
        <div className="homepage">
            <h1>Welcome to the Home Page</h1>
            <h1>Hello {state.name}</h1>
            <h2>Email: {state.email}</h2>
            <div className="button" onClick={() => setLoginUser({})}>Logout</div>
        </div>
    )
}
export default Homepage