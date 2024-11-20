import React, { useState } from "react";
import { Card, CardContent } from "@mui/material";
import { Button } from "@mui/material";
import CustomField from "./CustomField";
import { TextField } from "@mui/material";
import Spinner from "./Spinner";

const EditCard = ({ building, toggleFunction, setUpdatedBuilding }) => {
  const {
    id,
    address_line_1,
    address_line_2,
    city,
    state,
    zip,
    custom_fields,
  } = building;

  const [formData, setFormData] = useState({
    addressLine1: address_line_1,
    addressLine2: address_line_2,
    city: city,
    state: state,
    zip: zip,
    customFields: custom_fields,
  });

  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleOnClick = async () => {
    const updatedBuilding = await patchBuilding(id, formData);
    if (!error) {
      setUpdatedBuilding(updatedBuilding);
      toggleFunction();
    }
  };

  const patchBuilding = async (id, data) => {
    setIsLoading(true);
    try {
      const res = await fetch(`/buildings/${id}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ building: data }),
      });
      return await res.json();
    } catch (error) {
      setError(error);
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return <Spinner />;
  }

  return (
    <Card>
      <CardContent>
        <p>
          <TextField
            required
            id="outlined-required"
            label="Address 1"
            variant="standard"
            defaultValue={address_line_1}
            value={formData["addressLine1"]}
            onChange={(e) => {
              setFormData((prevData) => ({
                ...prevData,
                ["address_line_1"]: e.target.value,
              }));
            }}
          />
        </p>
        <p>
          <TextField
            id="outlined"
            label="Address 2"
            variant="standard"
            defaultValue={address_line_2}
            value={formData["addressLine2"]}
            onChange={(e) => {
              setFormData((prevData) => ({
                ...prevData,
                ["address_line_2"]: e.target.value,
              }));
            }}
          />
        </p>
        <p>
          <TextField
            required
            id="outlined-required"
            label="City"
            variant="standard"
            defaultValue={city}
            value={formData["city"]}
            onChange={(e) => {
              setFormData((prevData) => ({
                ...prevData,
                ["city"]: e.target.value,
              }));
            }}
          />
        </p>
        <p>
          <TextField
            required
            id="outlined-required"
            label="State"
            variant="standard"
            defaultValue={state}
            value={formData["state"]}
            onChange={(e) => {
              setFormData((prevData) => ({
                ...prevData,
                ["state"]: e.target.value,
              }));
            }}
          />
        </p>
        <p>
          <TextField
            required
            id="outlined-required"
            label="Zip"
            variant="standard"
            defaultValue={zip}
            value={formData["zip"]}
            onChange={(e) => {
              setFormData((prevData) => ({
                ...prevData,
                ["zip"]: e.target.value,
              }));
            }}
          />
        </p>
        {custom_fields.map((el, i) => {
          <CustomField key={i} el={el} />;
        })}
        <p>
          <Button variant="contained" onClick={() => handleOnClick()}>
            Save
          </Button>
        </p>
      </CardContent>
    </Card>
  );
};

export default EditCard;
