function contact = is_in_contact(data, const)
    contact = data.u(end) >= const.gap;