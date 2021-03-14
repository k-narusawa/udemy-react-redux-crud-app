import _ from "lodash";
import {
  CREATE_EVENT,
  DELETE_EVENT,
  READ_EVENT,
  READ_EVENTS,
  UPDATE_EVENT,
} from "../actions";

// eslint-disable-next-line import/no-anonymous-default-export
export default (events = {}, action) => {
  switch (action.type) {
    case READ_EVENTS:
      return _.mapKeys(action.response.data, "id");
    case DELETE_EVENT:
      delete events[action.id];
      return { ...events };
    case CREATE_EVENT:
    case READ_EVENT:
    case UPDATE_EVENT:
      const data = action.response.data;
      return { ...events, [data.id]: data };
    default:
      return events;
  }
};
