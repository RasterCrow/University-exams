package it.uniupo.labAlgo2;

import java.util.ArrayList;

import it.uniupo.graphLib.DirectedGraph;
import it.uniupo.graphLib.GraphUtils;

public class Kosaraju {
	private boolean[] scoperti;
	private boolean[] scoperti2;

	private ArrayList<Integer> ordineFineVisita;
	private DirectedGraph grafo;
	private int[] scc;
	private DirectedGraph reverseG;
	
	public Kosaraju(DirectedGraph g){
		grafo=g;
	}
	
	public ArrayList<Integer> postVisitList(){
		ordineFineVisita = new ArrayList<Integer>();
		scoperti = new boolean[grafo.getOrder()];
		for(int i=0; i< grafo.getOrder(); i++) {
			if(!scoperti[i])
				DFS(i);
		}
		return ordineFineVisita;
		
	}
	
	private void DFS(int nodo) {
		scoperti[nodo] = true;
		Iterable<Integer> vicini = grafo.getNeighbors(nodo);
		for(int vicino: vicini) {
			if(!scoperti[vicino]) {
				DFS(vicino);
			}
		}
		ordineFineVisita.add(nodo);
		
		
	}
	
	public int[] getSCC() {
		scoperti2 = new boolean[grafo.getOrder()];
		scc = new int[grafo.getOrder()];
		postVisitList();
		int sccIndex = 0;
		reverseG = GraphUtils.reverseGraph(grafo);
		
		for(int i = ordineFineVisita.size()-1; i>=0; i--) {
			if(!scoperti2[ordineFineVisita.get(i)]) {
				sccIndex = sccIndex+1;
				
				SCCdfs(ordineFineVisita.get(i), sccIndex);
			}
		}

		return scc;
	}
	
	private void SCCdfs(int nodo, int sccIndex) {
		scc[nodo] = sccIndex;
		scoperti2[nodo] = true;
		Iterable<Integer> vicini = reverseG.getNeighbors(nodo);
		for(int vicino: vicini) {
			if(!scoperti2[vicino]) {
				SCCdfs(vicino, sccIndex);
			}
		}
	}
}
