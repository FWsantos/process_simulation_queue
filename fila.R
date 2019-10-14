n=100

## tempos de chegada
cheg = rgamma(n,1,10)

cheg2 = cheg[1]

## tempos de chegada acumulados
for( i in 2:length(cheg) )
  cheg2[i] = cheg[i]+cheg2[i-1]

## tempos de atendimento
atend = rgamma(n,1,11)

atend2 = atend[1]

## tempos de atendimento acumulados
for( i in 2:length(atend) )
  atend2[i] = atend[i]+atend2[i-1]

## grafico de tempos de atendimento e chegada
plot(atend2,1:n,type='s',col='red')
points(cheg2,1:n,type="s")

fila = rep(0,2*n)
indice_fim = 0 

## simulando a fila
for( i in 2:length(fila) ){
  ## caso acabe algum dos vetores de atendimento e chegada, sair do laço
  if(length(atend2)==0 | length(cheg2)==0){
    indice_fim = i-1
    break
  }
  ## caso que o tamanho da fila é 0
  if(fila[i-1]==0){
    atend2 = atend2 + cheg2[2]-cheg2[1]
    fila[i] = 1
    cheg2 = cheg2[-1]
  } else {
    ## caso que o atendimento é mais rápido que a chegada
    if(atend2[1]<=cheg2[1]){
      atend2 = atend2[-1]
      fila[i] = fila[i-1]-1
    ## caso que a chegada é mais rápida que o atendimento
    } else {
        cheg2 = cheg2[-1]
        fila[i] = fila[i-1]+1
    }
  }
}

fila = fila[1:indice_fim]

plot(1:length(fila),fila,type="s",xlab="Instante",ylab="Tamanho da fila",
main="Fila Simulada")

