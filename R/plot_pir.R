#' Pirâmides populacionais com os arquivos de população
#' disponibilizados pelo DATASUS
#' @aliases plot_pir
#' 
#' @importFrom utils read.table write.table
#' 
#' @param pop Um \code{data frame} com a estrutura dos arquivos "POPBR??.DBF" disponibilizados pelo DATASUS, ou uma tabela com o sexo nas colunas (masc, fem) e a idade em 17 faixas etárias (0-4, ... 75-79, 80+) nas linhas
#' @param tabela Argumento lógico. Padrão é \code{FALSE}, deve ser mudado para \code{TRUE} quando a população é uma tabela como indicado acima
#' @param ano Indicar o período de referência. Apenas para quando a população é uma tabela
#' @param local Para o título: de onde é a população representada?
#' @param nfxetar No. de faixas etárias a serem representadas. Por enquanto única opção é 17 (quinquenais até 80 e +), tá na espera pra incluir outras opções
#' @param axes Não sei se vale a pena ir como opção ou já colocar direto o padrão FALSE. **Ver melhor**
#' @param fonte Texto para citar a fonte ao pé do gráfico
#' @param x.lim Limite do eixo x
#' @param colmasc Cor para o sexo masculino
#' @param colfem Cor para o sexo feminino
#' @param colfxetar Cor para os rótulos da faixa etária
#' @param border Cor da borda das barras
#' @param inside Ver a função \code{\link{barplot}} 
#' @param title Título do gáfico
#' @param fontsize Tamanho de fonte do título do gráfico
#' @param drop.unused.levels Apagar níveis não usados nos fatores?
#' @param ... argumentos de outras funções
#' @family csapAIH
#' @export
#' @examples 
#' \dontrun{
#' data("POPBR12")
#' plot_pir(POPBR12, local = 'Brasil')
#' plot_pir(POPBR12[substr(POPBR12$MUNIC_RES, 1,2)==42, ], local='Santa Catarina')
#' plot_pir(POPBR12[substr(POPBR12$MUNIC_RES, 1,2)==43, ], local='Rio Grande do Sul')
#' plot_pir(POPBR12[POPBR12$MUNIC_RES==431490, ], local='Porto Alegre, RS')
#' plot_pir(POPBR12[POPBR12$MUNIC_RES==430520, ], local='Cerro Largo, RS')
#' }
#' 
plot_pir <- 
function(pop, tabela = FALSE, ano = NULL, local="popula\U00e7\U00e3o", title = NULL, fontsize = 1.1, nfxetar = 17, axes=FALSE, fonte=NULL, x.lim=NULL, colmasc="mediumblue", colfem="red2", colfxetar="white", border=par("fg"), inside=T, drop.unused.levels = FALSE, ...)
{
  if(tabela == FALSE) {
# Reduzir nomes de variáveis em maiúsculas
pop <- Hmisc::upData(pop, lowernames=T)
# -.-.-.-.-.-.-.-.- PREPARAR A VARIÁVEL FAIXA ETÁRIA -.-.-.-.-.-.-.-.-
pop$fxetaria <- as.factor(pop$fxetaria)
nfaixas = length(levels(pop$fxetaria))

if(is.null(pop$fxetar5)) {
  pop$fxetar5 <- cut(as.numeric(pop$fxetaria), breaks = c(0, 5, 10, 15, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33))
  levels(pop$fxetar5) <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80 +")
}
  
# -.-.-.-.-.-.-.-.- TABULAR A BASE, ESCREVER ARQUIVO E CRIAR OBJETO "pir"
  xx <- xtabs(populacao ~ fxetar5 + sexo, data = pop, 
              drop.unused.levels = drop.unused.levels)
  colnames(xx) <- c('masculino', 'feminino')
  write.table(xx, "apagar.dat")
  pir <- read.table("apagar.dat")
  file.remove("apagar.dat")
  ano <- pop$ano[1]
  }  
  if(tabela == TRUE) {
    pir <- pop
    if(is.null(ano)) ano <- "ano"
    names(pir) <- colnames(pir)
  }
  masc   <- names(pir)[1]
  fem    <- names(pir)[2]
  limite <- round(max(prop.table(pir)),digits=2)
  if(is.null(x.lim)) limite <- limite
    else limite <- x.lim
  metade <- limite/2
  eixo <- seq(-limite, limite, by = metade)
  npop <- formatC(sum(pir), format="fg", big.mark=".", decimal.mark = ",")
  if(is.null(fonte))
    fonte <- "Fonte: DATASUS (www.datasus.gov.br)" #, ano"
  else fonte <- fonte
  # }
# .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
#                    Pirâmide populacional
# .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
  par(xpd=NA)
  barplot(height    = -prop.table(pir)[,1], 
          horiz     = T, 
          xlim      = c(-limite, limite), 
          space     = 0, 
          col       = colmasc, 
          border    = border, 
          font      = 2, 
          axes      = axes, 
          axisnames = FALSE)
  barplot(height    = prop.table(pir)[,2], 
          horiz     = T, 
          xlim      = c(-limite, limite), 
          space     = 0, 
          col       = colfem, 
          border    = border, 
          axes      = axes, 
          axisnames = FALSE, 
          add       = T)
  axis(side     = 1, 
       at       = seq(-limite, limite, by=metade), 
       labels   = paste(c(limite, metade, 0, metade, limite)*100, "%", sep=""), 
       font     = 2, 
       cex.axis = fontsize-.2)
  text(x = 0, y = seq(1:nfxetar), 
       labels=row.names(pir), 
       adj=c(0.5,1), 
       font=2, 
       col=colfxetar, 
       cex = fontsize-.35)
  if(is.null(title)) 
    title(main = paste("Pir\U00e2mide populacional.  ", 
                       local, ",  ", ano, ".", sep=""), 
          cex.main = fontsize, ...) 
  else title(main = title, cex.main = fontsize, ...)

  mtext(paste("(n =", npop, "hab.)"), cex=fontsize-.3, font=2)
  text(-metade, -4, masc, font=2, col=colmasc, cex = fontsize-.2)
  text(metade, -4, fem, font=2, col=colfem, cex = fontsize-.2)
  text(-(metade*1), -5, fonte, cex=fontsize-.35, font=4)
  segments(-prop.table(pir)[,1][17], 17, prop.table(pir)[,2][17], 17, col="white")
  
return(pir)
}
