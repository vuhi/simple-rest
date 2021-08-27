package com.ge.atv.simplerest.services;

import com.ge.atv.simplerest.daos.Role;

import java.util.List;

public interface IRoleService {
    public List<Role> findAll();
}
