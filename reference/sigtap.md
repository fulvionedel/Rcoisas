# Classifica os procedimentos do SISAB em grandes grupos de procedimentos da tabela SIGTAP.

Classifica os procedimentos do SISAB em grandes grupos de procedimentos
da tabela SIGTAP.

## Usage

``` r
sigtap(df, varproc = "CO_PROCEDIMENTO", nomeproc = FALSE)
```

## Arguments

- df:

  Banco de dados com os procedimentos. Parâmetro obrigatório não
  definido *a priori*.

- varproc:

  Nome da variável com o código do procedimento. Por padrão é
  "CO_PROCEDIMENTO" e deve vir entre aspas, simples ou duplas.

- nomeproc:

  Deve-se criar uma variável com o nome do procedimento?

## Note

Agradeço a Matheus Pacheco Andrade, da Gerência de Informação da
Secretaria Municipal de Saúde de Florianópolis, SC, por ter encontrado
as tabelas no servidor FTP do DATASUS.

## Examples

``` r
if (FALSE) { # \dontrun{
  sigtap(df = procedimentos, 'CO_PROCEDIMENTO') |> head()
  sigtap(procedimentos) |> head()
  sigtap(procedimentos, nomeproc = TRUE) |> head()
} # }
data("PASC2512")
sigtap(PASC2512, "PA_PROC_ID") |> head()
#>   PA_CODUNI PA_GESTAO PA_CONDIC PA_UFMUN PA_REGCT PA_INCOUT PA_INCURG PA_TPUPS
#> 1   2302012    421930        PG   421930     0000      0000      0000       02
#> 2   9383441    420910        PG   420910     0000      0000      0000       36
#> 3   7066953    420820        PG   420820     7114      0000      0000       73
#> 4   9010459    421190        PG   421190     0000      0000      0000       73
#> 5   4090276    421190        PG   421190     0000      0000      0000       39
#> 6   2302047    421930        PG   421930     0000      0000      0000       02
#>   PA_TIPPRE PA_MN_IND     PA_CNPJCPF     PA_CNPJMNT     PA_CNPJ_CC PA_MVM
#> 1        00         M 83039842000184 83039842000184 00000000000000 202512
#> 2        00         M 79361028000104 79361028000104 00000000000000 202512
#> 3        00         M 83102277000152 83102277000152 00000000000000 202512
#> 4        00         M 82892316000361 82892316000361 00000000000000 202512
#> 5        00         I 44647938000173 00000000000000 00000000000000 202512
#> 6        00         M 83039842000184 83039842000184 00000000000000 202512
#>   PA_CMP PA_PROC_ID PA_TPFIN PA_SUBFIN PA_NIVCPL PA_DOCORIG    PA_AUTORIZ
#> 1 202512 0301010064       01      0000         1          I 0000000000000
#> 2 202512 0302060014       06      0000         2          I 0000000000000
#> 3 202512 0301060029       06      0000         2          I 0000000000000
#> 4 202512 0301060118       06      0000         2          I 0000000000000
#> 5 202512 0204030188       06      0000         2          I 0000000000000
#> 6 202512 0301010064       01      0000         1          I 0000000000000
#>         PA_CNSMED PA_CBOCOD PA_MOTSAI PA_OBITO PA_ENCERR PA_PERMAN PA_ALTA
#> 1 709202280016938    225142        00        0         0         0       0
#> 2 706304703471974    223605        00        0         0         0       0
#> 3 705803434218333    225125        00        0         0         0       0
#> 4 708202693076445    223505        00        0         0         0       0
#> 5 708805773191310    225320        00        0         0         0       0
#> 6 700405974453450    225142        00        0         0         0       0
#>   PA_TRANSF PA_CIDPRI PA_CIDSEC PA_CIDCAS PA_CATEND PA_IDADE IDADEMIN IDADEMAX
#> 1         0      0000      0000      0000        01      034        0      130
#> 2         0      G822      0000      0000        01      023        0      130
#> 3         0      Z000      0000      0000        02      025        0      130
#> 4         0      0000      0000      0000        02      004        0      130
#> 5         0      0000      0000      0000        01      040       35      130
#> 6         0      0000      0000      0000        01      053        0      130
#>   PA_FLIDADE PA_SEXO PA_RACACOR PA_MUNPCN PA_QTDPRO PA_QTDAPR PA_VALPRO
#> 1          1       F         04    421930         1         1      0.00
#> 2          1       M         01    420910         1         1      4.67
#> 3          1       F         04    420820         1         1     12.47
#> 4          1       F         04    421190         1         1      0.00
#> 5          1       F         01    421190         1         1     45.00
#> 6          1       F         04    421930         1         1      0.00
#>   PA_VALAPR PA_UFDIF PA_MNDIF PA_DIF_VAL NU_VPA_TOT NU_PA_TOT PA_INDICA
#> 1      0.00        0        0          0          0      0.00         5
#> 2      4.67        0        0          0          0      4.67         5
#> 3     12.47        0        0          0          0     12.47         5
#> 4      0.00        0        0          0          0      0.00         5
#> 5     45.00        0        0          0          0     45.00         5
#> 6      0.00        0        0          0          0      0.00         5
#>   PA_CODOCO PA_FLQT PA_FLER PA_ETNIA PA_VL_CF PA_VL_CL PA_VL_INC PA_SRV_C
#> 1         1       K       0     <NA>        0        0         0     <NA>
#> 2         1       K       0     <NA>        0        0         0   135003
#> 3         1       K       0     <NA>        0        0         0     <NA>
#> 4         1       K       0     <NA>        0        0         0     <NA>
#> 5         1       K       0     <NA>        0        0         0   121012
#> 6         1       K       0     <NA>        0        0         0     <NA>
#>   PA_INE PA_NAT_JUR PA_FNTORC
#> 1   <NA>       1244      <NA>
#> 2   <NA>       1031      <NA>
#> 3   <NA>       1244      <NA>
#> 4   <NA>       1244      <NA>
#> 5   <NA>       2062      <NA>
#> 6   <NA>       1244      <NA>
#>                                                   GRUPO
#> 1 03. Procedimentos clínicos                           
#> 2 03. Procedimentos clínicos                           
#> 3 03. Procedimentos clínicos                           
#> 4 03. Procedimentos clínicos                           
#> 5 02. Procedimentos com finalidade diagnóstica         
#> 6 03. Procedimentos clínicos                           
#>                                           SUBGRUPO
#> 1 0301. Consultas / Atendimentos / Acompanhamentos
#> 2                               0302. Fisioterapia
#> 3 0301. Consultas / Atendimentos / Acompanhamentos
#> 4 0301. Consultas / Atendimentos / Acompanhamentos
#> 5                 0204. Diagnóstico por radiologia
#> 6 0301. Consultas / Atendimentos / Acompanhamentos
#>                                                       FORMA
#> 1  030101. Consultas médicas/outros profissionais  de nivel
#> 2 030206. Assistência fisioterapêutica nas alterações em ne
#> 3      030106. Consulta/Atendimento ás urgências (em geral)
#> 4      030106. Consulta/Atendimento ás urgências (em geral)
#> 5         020403. Exames radiológicos do torax e mediastino
#> 6  030101. Consultas médicas/outros profissionais  de nivel
sigtap(PASC2512, "PA_PROC_ID", nomeproc = TRUE) |> head()
#>   PA_CODUNI PA_GESTAO PA_CONDIC PA_UFMUN PA_REGCT PA_INCOUT PA_INCURG PA_TPUPS
#> 1   2302012    421930        PG   421930     0000      0000      0000       02
#> 2   9383441    420910        PG   420910     0000      0000      0000       36
#> 3   7066953    420820        PG   420820     7114      0000      0000       73
#> 4   9010459    421190        PG   421190     0000      0000      0000       73
#> 5   4090276    421190        PG   421190     0000      0000      0000       39
#> 6   2302047    421930        PG   421930     0000      0000      0000       02
#>   PA_TIPPRE PA_MN_IND     PA_CNPJCPF     PA_CNPJMNT     PA_CNPJ_CC PA_MVM
#> 1        00         M 83039842000184 83039842000184 00000000000000 202512
#> 2        00         M 79361028000104 79361028000104 00000000000000 202512
#> 3        00         M 83102277000152 83102277000152 00000000000000 202512
#> 4        00         M 82892316000361 82892316000361 00000000000000 202512
#> 5        00         I 44647938000173 00000000000000 00000000000000 202512
#> 6        00         M 83039842000184 83039842000184 00000000000000 202512
#>   PA_CMP PA_PROC_ID PA_TPFIN PA_SUBFIN PA_NIVCPL PA_DOCORIG    PA_AUTORIZ
#> 1 202512 0301010064       01      0000         1          I 0000000000000
#> 2 202512 0302060014       06      0000         2          I 0000000000000
#> 3 202512 0301060029       06      0000         2          I 0000000000000
#> 4 202512 0301060118       06      0000         2          I 0000000000000
#> 5 202512 0204030188       06      0000         2          I 0000000000000
#> 6 202512 0301010064       01      0000         1          I 0000000000000
#>         PA_CNSMED PA_CBOCOD PA_MOTSAI PA_OBITO PA_ENCERR PA_PERMAN PA_ALTA
#> 1 709202280016938    225142        00        0         0         0       0
#> 2 706304703471974    223605        00        0         0         0       0
#> 3 705803434218333    225125        00        0         0         0       0
#> 4 708202693076445    223505        00        0         0         0       0
#> 5 708805773191310    225320        00        0         0         0       0
#> 6 700405974453450    225142        00        0         0         0       0
#>   PA_TRANSF PA_CIDPRI PA_CIDSEC PA_CIDCAS PA_CATEND PA_IDADE IDADEMIN IDADEMAX
#> 1         0      0000      0000      0000        01      034        0      130
#> 2         0      G822      0000      0000        01      023        0      130
#> 3         0      Z000      0000      0000        02      025        0      130
#> 4         0      0000      0000      0000        02      004        0      130
#> 5         0      0000      0000      0000        01      040       35      130
#> 6         0      0000      0000      0000        01      053        0      130
#>   PA_FLIDADE PA_SEXO PA_RACACOR PA_MUNPCN PA_QTDPRO PA_QTDAPR PA_VALPRO
#> 1          1       F         04    421930         1         1      0.00
#> 2          1       M         01    420910         1         1      4.67
#> 3          1       F         04    420820         1         1     12.47
#> 4          1       F         04    421190         1         1      0.00
#> 5          1       F         01    421190         1         1     45.00
#> 6          1       F         04    421930         1         1      0.00
#>   PA_VALAPR PA_UFDIF PA_MNDIF PA_DIF_VAL NU_VPA_TOT NU_PA_TOT PA_INDICA
#> 1      0.00        0        0          0          0      0.00         5
#> 2      4.67        0        0          0          0      4.67         5
#> 3     12.47        0        0          0          0     12.47         5
#> 4      0.00        0        0          0          0      0.00         5
#> 5     45.00        0        0          0          0     45.00         5
#> 6      0.00        0        0          0          0      0.00         5
#>   PA_CODOCO PA_FLQT PA_FLER PA_ETNIA PA_VL_CF PA_VL_CL PA_VL_INC PA_SRV_C
#> 1         1       K       0     <NA>        0        0         0     <NA>
#> 2         1       K       0     <NA>        0        0         0   135003
#> 3         1       K       0     <NA>        0        0         0     <NA>
#> 4         1       K       0     <NA>        0        0         0     <NA>
#> 5         1       K       0     <NA>        0        0         0   121012
#> 6         1       K       0     <NA>        0        0         0     <NA>
#>   PA_INE PA_NAT_JUR PA_FNTORC
#> 1   <NA>       1244      <NA>
#> 2   <NA>       1031      <NA>
#> 3   <NA>       1244      <NA>
#> 4   <NA>       1244      <NA>
#> 5   <NA>       2062      <NA>
#> 6   <NA>       1244      <NA>
#>                                                   GRUPO
#> 1 03. Procedimentos clínicos                           
#> 2 03. Procedimentos clínicos                           
#> 3 03. Procedimentos clínicos                           
#> 4 03. Procedimentos clínicos                           
#> 5 02. Procedimentos com finalidade diagnóstica         
#> 6 03. Procedimentos clínicos                           
#>                                           SUBGRUPO
#> 1 0301. Consultas / Atendimentos / Acompanhamentos
#> 2                               0302. Fisioterapia
#> 3 0301. Consultas / Atendimentos / Acompanhamentos
#> 4 0301. Consultas / Atendimentos / Acompanhamentos
#> 5                 0204. Diagnóstico por radiologia
#> 6 0301. Consultas / Atendimentos / Acompanhamentos
#>                                                       FORMA
#> 1  030101. Consultas médicas/outros profissionais  de nivel
#> 2 030206. Assistência fisioterapêutica nas alterações em ne
#> 3      030106. Consulta/Atendimento ás urgências (em geral)
#> 4      030106. Consulta/Atendimento ás urgências (em geral)
#> 5         020403. Exames radiológicos do torax e mediastino
#> 6  030101. Consultas médicas/outros profissionais  de nivel
#>                                                                                      PROCEDIMENTO2
#> 1                                                              CONSULTA MEDICA EM ATENCAO PRIMARIA
#> 2 ATENDIMENTO FISIOTERAPEUTICO EM PACIENTES COM DISTURBIOS NEURO-CINETICO-FUNCIONAIS SEM COMPLICAC
#> 3                      ATENDIMENTO DE URGENCIA C/ OBSERVACAO ATE 24 HORAS EM ATENCAO ESPECIALIZADA
#> 4                                                           ACOLHIMENTO COM CLASSIFICACAO DE RISCO
#> 5                                                           MAMOGRAFIA BILATERAL PARA RASTREAMENTO
#> 6                                                              CONSULTA MEDICA EM ATENCAO PRIMARIA

# A lista completa de códigos classificados em grupos pode ser conseguida com:
sigtap(Rcoisas:::tabproc) |> head()
#>   CO_PROCEDIMENTO
#> 1      0101010010
#> 2      0101010028
#> 3      0101010036
#> 4      0101010044
#> 5      0101010052
#> 6      0101010060
#>                                                         PROCEDIMENTO
#> 1      ATIVIDADE EDUCATIVA / ORIENTACAO EM GRUPO NA ATENCAO PRIMARIA
#> 2 ATIVIDADE EDUCATIVA / ORIENTACAO EM GRUPO NA ATENCAO ESPECIALIZADA
#> 3                       PRATICA CORPORAL / ATIVIDADE FISICA EM GRUPO
#> 4                 PRATICAS CORPORAIS EM MEDICINA TRADICIONAL CHINESA
#> 5                                                TERAPIA COMUNITARIA
#> 6                                            DANCA CIRCULAR/BIODANCA
#>                                                   GRUPO
#> 1 01. Ações de promoção e prevenção em saúde           
#> 2 01. Ações de promoção e prevenção em saúde           
#> 3 01. Ações de promoção e prevenção em saúde           
#> 4 01. Ações de promoção e prevenção em saúde           
#> 5 01. Ações de promoção e prevenção em saúde           
#> 6 01. Ações de promoção e prevenção em saúde           
#>                                     SUBGRUPO                     FORMA
#> 1 0101. Ações coletivas/individuais em saúde 010101. Educação em saúde
#> 2 0101. Ações coletivas/individuais em saúde 010101. Educação em saúde
#> 3 0101. Ações coletivas/individuais em saúde 010101. Educação em saúde
#> 4 0101. Ações coletivas/individuais em saúde 010101. Educação em saúde
#> 5 0101. Ações coletivas/individuais em saúde 010101. Educação em saúde
#> 6 0101. Ações coletivas/individuais em saúde 010101. Educação em saúde
```
