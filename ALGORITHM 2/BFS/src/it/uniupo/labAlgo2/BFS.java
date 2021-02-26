package it.uniupo.labAlgo2;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Queue;

import it.uniupo.graphLib.Edge;
import it.uniupo.graphLib.GraphInterface;

public class BFS {
	// variabili di istanza
	GraphInterface grafo; // per memorizzare il grafo su cui si lavora
	boolean[] scoperto; // per memorizzare i nodi scoperti: scoperti[2]=true se il nodo 2 e' stato
						// scoperto
	ArrayList<Integer> nodiVisitatiInOrdine; // elenco dei nodi nell'ordine in cui sono stati visitati
	int[] distanza; // distanza[v] = distanza del nodo v dalla sorgente

	/****************************
	 * Questo e' il costruttore
	 ****************************/
	public BFS(GraphInterface grafoInInput) {
		grafo = grafoInInput;
	}

	private void visitaBFS(int sorgente) {
		scoperto = new boolean[grafo.getOrder()];
		nodiVisitatiInOrdine = new ArrayList<Integer>();
		ArrayList<Integer> coda = new ArrayList<Integer>();
		coda.add(sorgente);
		int nodo;
		while (!coda.isEmpty()) {
			nodo = coda.get(0);
			if (!scoperto[nodo]) {
				scoperto[nodo] = true;
				nodiVisitatiInOrdine.add(nodo);
				for (int vicino : grafo.getNeighbors(nodo)) {
					coda.add(vicino);
				}
			}
		}
	}

	public ArrayList<Integer> getNodesInOrderOfVisit(int sorgente) {
		scoperto = new boolean[grafo.getOrder()];
		nodiVisitatiInOrdine = new ArrayList<Integer>();
		ArrayList<Integer> coda = new ArrayList<Integer>();
		coda.add(sorgente);
		scoperto[sorgente] = true;
		int nodo;
		while (!coda.isEmpty()) {
			nodo = coda.remove(0);
			nodiVisitatiInOrdine.add(nodo);
			for (int vicino : grafo.getNeighbors(nodo)) {
				if (!scoperto[vicino]) {
					coda.add(vicino);
					scoperto[vicino] = true;
				}
			}
		}
		return nodiVisitatiInOrdine;
	}

	public int[] getDistance(int sorgente) { // resituisce le distanza di ciascun nodo da sorg
		scoperto = new boolean[grafo.getOrder()];
		distanza = new int[grafo.getOrder()];
		ArrayList<Integer> coda = new ArrayList<Integer>();
		distanza[sorgente] = 0;
		scoperto[sorgente] = true;
		coda.add(sorgente);
		int nodo;
		while (!coda.isEmpty()) {
			nodo = coda.remove(0);
			for (int vicino : grafo.getNeighbors(nodo)) {
				if (!scoperto[vicino]) {
					coda.add(vicino);
					scoperto[vicino] = true;
					distanza[vicino] = distanza[nodo] + 1;

				}
			}
		}
		System.out.println("fine");
		return distanza;

	}

	public GraphInterface bfsTree(int sorgente) {
		ArrayList<Integer> coda = new ArrayList<Integer>();
		scoperto = new boolean[grafo.getOrder()];
		GraphInterface tree = grafo.create();
		int nodo;
		coda.add(sorgente);
		scoperto[sorgente] = true;
		while (!coda.isEmpty()) {
			nodo = coda.remove(0);
			for (int vicino : grafo.getNeighbors(nodo)) {
				if (!scoperto[vicino]) {
					coda.add(vicino);
					scoperto[vicino] = true;
					// aggiungere arco al tree
					tree.addEdge(nodo, vicino);
				}
			}
		}
		System.out.println("fine");
		return tree;

	}

}
