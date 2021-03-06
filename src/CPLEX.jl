__precompile__()

module CPLEX
    using Libdl

    @static if Sys.isapple()
        Libdl.dlopen("libstdc++",Libdl.RTLD_GLOBAL)
    end

    if isfile(joinpath(dirname(@__FILE__),"..","deps","deps.jl"))
        include("../deps/deps.jl")
    else
        error("CPLEX not properly installed. Please run Pkg.build(\"CPLEX\")")
    end

    ### imports
    import Base: convert, unsafe_convert, show, copy

    # Standard LP interface
    using MathProgBase.SolverInterface

    # exported functions
    # export is_valid,
    #        set_logfile,
    #        get_error_msg,
    #        read_model,
    #        write_model,
    #        get_sense,
    #        set_sense!,
    #        get_obj,
    #        set_obj!,
    #        set_warm_start!,
    #        free_problem,
    #        close_CPLEX,
    #        get_param_type,
    #        set_param!,
    #        get_param,
    #        add_vars!,
    #        add_var!,
    #        get_varLB,
    #        set_varLB!,
    #        get_varUB,
    #        set_varUB!,
    #        set_vartype!,
    #        get_vartype,
    #        num_var,
    #        add_constrs!,
    #        add_constrs_t!,
    #        add_rangeconstrs!,
    #        add_rangeconstrs_t!,
    #        num_constr,
    #        get_constr_senses,
    #        set_constr_senses!,
    #        get_rhs,
    #        set_rhs!,
    #        get_constrLB,
    #        get_constrUB,
    #        set_constrLB!,
    #        set_constrUB!,
    #        get_nnz,
    #        get_constr_matrix,
    #        set_sos!,
    #        add_qpterms!,
    #        add_diag_qpterms!,
    #        add_qconstr!,
    #        optimize!,
    #        get_objval,
    #        get_solution,
    #        get_reduced_costs,
    #        get_constr_duals,
    #        get_constr_solution,
    #        get_infeasibility_ray,
    #        get_unbounded_ray,
    #        get_status,
    #        get_status_code,
    #        setcallbackcut,
    #        cbcut,
    #        cblazy,
    #        cbget_mipnode_rel,
    #        cbget_mipsol_sol,
    #        cplex_model

    using SparseArrays
    using LinearAlgebra

    include("cpx_common.jl")
    include("cpx_env.jl")
    v = version()
    if startswith(v,"12.8")
        include("full_defines_1280.jl")
        include("cpx_params_1280.jl")
    elseif startswith(v,"12.9")
        include("full_defines_1290.jl")
        include("cpx_params_1290.jl")
    else
        error("Unsupported CPLEX version $v. Only 12.8 and 12.9 are currently supported.")
    end
    include("cpx_model.jl")
    include("cpx_params.jl")
    include("cpx_vars.jl")
    include("cpx_constrs.jl")
    include("cpx_quad.jl")
    include("cpx_solve.jl")
    include("cpx_callbacks.jl")
    include("cpx_highlevel.jl")
    include("cpx_generic_callbacks.jl")

    include("CplexSolverInterface.jl")
    include("MOI/MOI_wrapper.jl")
end
