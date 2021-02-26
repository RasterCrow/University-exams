package it.uniupo.labAlgo2;


import it.uniupo.algoTools.MinHeap;
import it.uniupo.graphLib.*;

//Esercizio per l-applicazione di dijkstra

public class Voli {
	
	private DirectedGraph grafo;
	private boolean[] scoperti;
	private MinHeap<Edge,Integer> heap;
	private int[] dist;
	
	public Voli (DirectedGraph collegamenti){
		grafo = collegamenti;
	}
	
	public int tempo (int partenza, int destinazione) throws IllegalArgumentException {
		//se partenza o destinazione non esistono
		if(partenza > grafo.getOrder() || destinazione > grafo.getOrder() || partenza < 0 || destinazione < 0)
			throw new java.lang.IllegalArgumentException();
		//variabili
		heap = new MinHeap<Edge,Integer>();
		scoperti= new boolean[grafo.getOrder()];
		Edge e;
		dist = new int[grafo.getOrder()];
		dist[partenza]=0;
		//dijkstra
		for(Edge edge: grafo.getOutEdges(partenza)) {
			if(edge.getHead()==destinazione) {
				return edge.getWeight();
			}
			heap.add(edge,edge.getWeight());
		}
		while(!heap.isEmpty()) {
			e = heap.extractMin();
			if(!scoperti[e.getHead()]) {
				dist[e.getHead()] = e.getWeight() + dist[e.getTail()];
				if(e.getHead()==destinazione) {
					return dist[e.getHead()];
				}
				scoperti[e.getHead()]=true;
				for(Edge edge: grafo.getOutEdges(e.getHead())) {
					if(!scoperti[edge.getHead()])
						heap.add(edge,edge.getWeight() + dist[edge.getTail()]);
				}
			}
		}
		//controllo finale se sono riuscito a raggiungere la destinazione
		
		return -1;
	}
	
	public int tempoMinimo(int partenza, int destinazione)throws IllegalArgumentException {
		//se partenza o destinazione non esistono
				if(partenza > grafo.getOrder() || destinazione > grafo.getOrder() || partenza < 0 || destinazione < 0)
					throw new java.lang.IllegalArgumentException();
				//variabili
				heap = new MinHeap<Edge,Integer>();
				scoperti= new boolean[grafo.getOrder()];
				Edge e;
				dist = new int[grafo.getOrder()];
				dist[partenza]=0;
				//dijkstra
				for(Edge edge: grafo.getOutEdges(partenza)) {
					heap.add(edge,edge.getWeight());
				}
				while(!heap.isEmpty()) {
					e = heap.extractMin();
					if(!scoperti[e.getHead()]) {
						dist[e.getHead()] = e.getWeight() + dist[e.getTail()];
						scoperti[e.getHead()]=true;
						for(Edge edge: grafo.getOutEdges(e.getHead())) {
							if(!scoperti[edge.getHead()])
								heap.add(edge,edge.getWeight() + dist[edge.getTail()]);
						}
					}
				}
				//controllo finale se sono riuscito a raggiungere la destinazione
				if(!scoperti[destinazione]) {
					return -1;
				}
				return dist[destinazione];
	}
	
	public int scali(int partenza, int destinazione) {
		//se partenza o destinazione non esistono
		if(partenza > grafo.getOrder() || destinazione > grafo.getOrder() || partenza < 0 || destinazione < 0)
			throw new java.lang.IllegalArgumentException();
		//variabili
		heap = new MinHeap<Edge,Integer>();
		scoperti= new boolean[grafo.getOrder()];
		Edge e;
		dist = new int[grafo.getOrder()];
		dist[partenza]=0;
		//dijkstra
		for(Edge edge: grafo.getOutEdges(partenza)) {
			if(edge.getHead()==destinazione) {
				return 0;
			}
			heap.add(edge,1 + dist[edge.getTail()]);
		}
		while(!heap.isEmpty()) {
			e = heap.extractMin();
			if(!scoperti[e.getHead()]) {
				dist[e.getHead()] =1 + dist[e.getTail()];
				scoperti[e.getHead()]=true;
				for(Edge edge: grafo.getOutEdges(e.getHead())) {
					if(!scoperti[edge.getHead()])
						heap.add(edge,1+ dist[edge.getTail()]);
				}
			}
		}
		//controllo finale se sono riuscito a raggiungere la destinazione
		if(!scoperti[destinazione]) {
			return -1;
		}
		return dist[destinazione];
	}
	
}
