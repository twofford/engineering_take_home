import React, { useEffect, useState } from "react";
import DisplayCard from "./DisplayCard";
import EditCard from "./EditCard";

const BuildingCard = ({ building }) => {
  const [isEditView, setIsEditView] = useState(false);
  const [updatedBuilding, setUpdatedBuilding] = useState(building);

  useEffect(() => {
    setUpdatedBuilding(building);
  }, [building]);

  const toggleEditView = () => {
    setIsEditView((prevState) => !prevState);
  };

  if (isEditView) {
    return (
      <EditCard
        building={updatedBuilding}
        toggleFunction={toggleEditView}
        setUpdatedBuilding={setUpdatedBuilding}
      />
    );
  } else {
    return (
      <DisplayCard building={updatedBuilding} toggleFunction={toggleEditView} />
    );
  }
};

export default BuildingCard;
