function [COEFF,SCORE,latent,ACOEFF,BCOEFF,rCORR,USCORE,VSCORE,stats,UltiCOEFF] = PCACCAPlot(Matrix,MatrixB,Head,GeneName,MetaName,d,N,dim,PCs)
%The input matrix is a gene X sample matrix
%             Sample1 Sample2 Sample3
%      gene1
%      gene2
%      gene3
%
%The input MatrixB is a metadata matrix
%             Sample1 Sample2 Sample3
%      meta1
%      meta2
%      meta3
%PCACCAPlot is a function to run PCAPlot, CCAPlot and additional coefficient calculations
%function [COEFF,SCORE,latent,ACOEFF,BCOEFF,rCORR,USCORE,VSCORE,stats,UltiCOEFF] = PCACCAPlot(Matrix,MatrixB,Head,GeneName,MetaName,d,N)
%This function depends on discretize.m which only works on Matlab R2016b or later
%dim is the number of PCs interested
if nargin < 9
    PCs = 1:dim;
end

figure;
[COEFF,SCORE,latent] = PCAPlot(Matrix,Head,GeneName,d,N,dim);
[ACOEFF,BCOEFF,rCORR,USCORE,VSCORE,stats] = CCAPlot(SCORE(:,PCs)',MatrixB,Head,Mat2StrArray(PCs'),MetaName,d,N,dim);
[Am An]=size(ACOEFF);
[Bm Bn]=size(BCOEFF);
iend=min(dim,min(An,Bn));
UltiCOEFF=COEFF(:,PCs)*ACOEFF;
AIndex=UltiCOEFF;
for i=1:iend
[testA,AIndex(:,i)]=sort(UltiCOEFF(:,i));
SaveCell([GeneName(AIndex(testA<0,i)) Mat2StrArray(testA(testA<0))],strcat(num2str(i),'_gene_neg.txt'));
SaveCell(flipud([GeneName(AIndex(testA>0,i)) Mat2StrArray(testA(testA>0))]),strcat(num2str(i),'_gene_pos.txt'));
end

end

