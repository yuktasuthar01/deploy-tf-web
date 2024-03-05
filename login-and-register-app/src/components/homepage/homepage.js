import React from "react"
import "./homepage.css"
import { useLocation } from "react-router"
import { useState } from 'react'

const Homepage = ({ setLoginUser }) => {
    const { state } = useLocation();
    const [data, setData] = useState(null);

    // useEffect(() => {
    //     // Fetch data when the component mounts
    //     fetch(`${serviceUrl}/tf-app-yukta.azurewebsites.net`)
    //       .then(response => response.json())
    //       .then(data => {
    //         setData(data);
    //       })
    //       .catch(error => {
    //         console.error("Error fetching data:", error);
    //       });
    //   }, [serviceUrl]);

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