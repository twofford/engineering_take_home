import React, { useState } from "react";
import { Box } from "@mui/material";
import { TextField, Button } from "@mui/material";
import useGetClients from "../hooks/useGetClients";

const CreateBuildingForm = () => {
  const { clients } = useGetClients();

  const [address1, setAddress1] = useState(null);
  const [address2, setAddress2] = useState(null);
  const [city, setCity] = useState(null);
  const [state, setState] = useState(null);
  const [zip, setZip] = useState(null);
  const [cf1Key, setCf1Key] = useState(null);
  const [cf2Key, setCf2Key] = useState(null);
  const [cf1Val, setCf1Val] = useState(null);
  const [cf2Val, setCf2Val] = useState(null);
  const [_error, setError] = useState(null);
  const [_isLoadng, setIsLoading] = useState(false);

  const handleSubmit = async () => {
    await postBuilding();
  };

  const postBuilding = async () => {
    try {
      const res = await fetch("/buildings", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          building: {
            address_line_1: address1,
            address_line_2: address2,
            city: city,
            state: state,
            zip: zip,
            custom_fields: { [cf1Key]: cf1Val, [cf2Key]: cf2Val },
            /*
            NOTE: Because there is no auth, I'm hardcoding the client id.
            In a real application, the client would get their id when they logged in
            and pass it the /buildings endpoint here.
            */
            client_id: clients[0]["id"],
          },
        }),
      });
      return await res.json();
    } catch (error) {
      setError(error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Box>
      <h2 style={{ display: "flex", justifyContent: "center" }}>
        Create Building
      </h2>

      <TextField
        required
        id="outlined-required"
        label="Address 1"
        variant="standard"
        defaultValue={address1}
        value={address1}
        onChange={(e) => {
          setAddress1(e.target.value);
        }}
      />
      <TextField
        id="outlined"
        label="Address 2"
        variant="standard"
        defaultValue={address2}
        value={address2}
        onChange={(e) => {
          setAddress2(e.target.value);
        }}
      />
      <TextField
        required
        id="outlined-required"
        label="City"
        variant="standard"
        defaultValue={city}
        value={city}
        onChange={(e) => {
          setCity(e.target.value);
        }}
      />
      <TextField
        required
        id="outlined-required"
        label="State"
        variant="standard"
        defaultValue={state}
        value={state}
        onChange={(e) => {
          setState(e.target.value);
        }}
      />
      <TextField
        required
        id="outlined-required"
        label="ZIP"
        variant="standard"
        defaultValue={zip}
        value={zip}
        onChange={(e) => {
          setZip(e.target.value);
        }}
      />
      <TextField
        id="outlined"
        label="Custom Field 1 Key"
        variant="standard"
        defaultValue={cf1Key}
        value={cf1Key}
        onChange={(e) => {
          setCf1Key(e.target.value);
        }}
      />
      <TextField
        id="outlined"
        label="Custom Field 1 Value"
        variant="standard"
        defaultValue={cf1Val}
        value={cf1Val}
        onChange={(e) => {
          setCf1Val(e.target.value);
        }}
      />
      <TextField
        id="outlined"
        label="Custom Field 2 Key"
        variant="standard"
        defaultValue={cf2Key}
        value={cf2Key}
        onChange={(e) => {
          setCf2Key(e.target.value);
        }}
      />
      <TextField
        id="outlined"
        label="Custom Field 2 Value"
        variant="standard"
        defaultValue={cf2Val}
        value={cf2Val}
        onChange={(e) => {
          setCf2Val(e.target.value);
        }}
      />
      <Button variant="contained" onClick={() => handleSubmit()}>
        Submit
      </Button>
    </Box>
  );
};

export default CreateBuildingForm;
