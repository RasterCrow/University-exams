package it.uniupo.labAlgo2;

import it.uniupo.algoTools.MinHeap;
import it.uniupo.graphLib.Edge;
import it.uniupo.graphLib.GraphInterface;

public class Dijkstra {
	private MinHeap<Edge,Integer> heap;
	private int[] dist;
	private GraphInterface grafo;
	private boolean[] scoperti;
	
	public Dijkstra(GraphInterface	g) {
		grafo = g;
	}
	
	public int[] getDistanze(int sorg) {
		scoperti = new boolean[grafo.getOrder()];
		dist = new int[grafo.getOrder()];
		heap = new MinHeap<Edge,Integer>();
		dist[sorg]= 0;
		Edge e;
		//per ogni arco in uscita dalla sorgente
		for(Edge edge: grafo.getOutEdges(sorg)) {
				//aggiungo alla heap
				heap.add(edge, edge.getWeight());
		}
		//finche la heap non [ vuota
		while(!heap.isEmpty()) {
			//prendo il minore
			e = heap.extractMin();

			//se non è gia stato scoeprto
			if(!scoperti[e.getHead()]) {
				//lo scopro
				scoperti[e.getHead()] =true;
				//aggiorno la sua distanza
				dist[e.getHead()] = dist[e.getTail()] + e.getWeight();
				//aggiungo ogni arco uscente alla heap, se il nodo figlio non é ancora stato scoperto
				for(Edge edge: grafo.getOutEdges(e.getHead())) {
						//se non scoperto
						if(!scoperti[edge.getHead()]) {
							heap.add(edge, dist[edge.getTail()] + edge.getWeight());
						}
				}
			}
		}
		
		return dist;
	}
}
