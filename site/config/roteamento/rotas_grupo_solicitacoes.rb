match 'grupos/solicitar/:idGrupo' => 'grupo#solicitarMinhaParticipacao', via: :get
match 'grupos/cancelarSolicitacao/:idGrupo' => 'grupo#cancelarMinhaSolicitacao', via: :get
match 'grupos/rejeitarSolicitacao/:idGrupo/:idDeQuem' => 'grupo#rejeitarSolicitacao', via: :get
match 'grupos/aceitarSolitacao/:idGrupo/:idDeQuem' => 'grupo#aceitarSolitacao', via: :get
