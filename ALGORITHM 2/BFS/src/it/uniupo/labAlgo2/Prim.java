package it.uniupo.labAlgo2;

import it.uniupo.algoTools.MinHeap;
import it.uniupo.graphLib.Edge;
import it.uniupo.graphLib.UndirectedGraph;

public class Prim {
	
	private boolean[] scoperti;
	private UndirectedGraph grafo;
	private UndirectedGraph mst;
	private MinHeap<Edge,Integer> heap;
	
	public Prim(UndirectedGraph g) {
		grafo = g;
	}
	
	public UndirectedGraph getMST(int sorgente) {
		scoperti = new boolean[grafo.getOrder()];
		mst = (UndirectedGraph) grafo.create();
		heap = new MinHeap<Edge,Integer>();
		scoperti[sorgente]=true;
		for(Edge arco : grafo.getOutEdges(sorgente)) {
			heap.add(arco, arco.getWeight());
		}
		Edge e;
		while(!heap.isEmpty()) {
			e = heap.extractMin();
			if(!scoperti[e.getHead()]) {
				scoperti[e.getHead()] = true;
				mst.addEdge(e);
				
				for(Edge arco : grafo.getOutEdges(e.getHead())) {
					if(!scoperti[arco.getHead()]) {
						heap.add(arco, arco.getWeight());
						System.out.println("aggiunto arco " + arco);
					}
				}
			}
		}
		
		return mst;
	}
	
	public int getMSTCost () {

		return 1;
	}

}
