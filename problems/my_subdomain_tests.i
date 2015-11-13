[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
  xmax = 1
  ymax = 1
  uniform_refine = 2
[]

[MeshModifiers]
  [./subdomains]
    type = SubdomainBoundingBox
    bottom_left = '0 0 0'
    block_id = 1
    top_right = '0.5 1.0 0'
  [../]
[]

[Variables]
  [./u]
    block = '0'
  [../]
  [./v]
    block = '1'
  [../]
[]

[Kernels]
  [./diff]
    type = MatCoefDiffusion
    variable = u
    conductivity = 'k'
    block = '0'
  [../]
  [./time]
    type = TimeDerivative
    variable = u
    block = '0'
  [../]
  [./diff_v]
    type = MatCoefDiffusion
    variable = u
    conductivity = 'k'
    block = '1'
  [../]
  [./time_v]
    type = TimeDerivative
    variable = v
    block = '1'
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = left
    value = 0
  [../]
  [./right]
    type = DirichletBC
    variable = u
    boundary = right
    value = 1
  [../]
[]

[Materials]
  [./outside]
    type = GenericConstantMaterial
    block = 0
    prop_names = 'k'
    prop_values = 1
  [../]
  [./inside]
    type = GenericConstantMaterial
    block = 1
    prop_names = 'k'
    prop_values = 0.001
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  type = Transient
  num_steps = 5
  dt = 0.1
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
[]