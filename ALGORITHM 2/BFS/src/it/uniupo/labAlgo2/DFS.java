package it.uniupo.labAlgo2;

import java.util.ArrayList;
import java.util.Stack;

import it.uniupo.graphLib.*;

public class DFS {
	private GraphInterface grafo;
	private boolean[] scoperto;
	private GraphInterface albero;
	private Stack<Integer> topOrd;
	private boolean exception;
	
	public DFS(GraphInterface g) {
		grafo = g;
	}
	
	public GraphInterface getTree(int sorgente) throws Exception{
		scoperto = new boolean[grafo.getOrder()];
		albero = grafo.create();
		exception = false;
		visita(sorgente);
		if(exception) {
			throw new Exception();
		}
		//System.out.println("fine");
		return albero;
	}
	
	private void visita(int nodo) {
		scoperto[nodo]=true;
		Iterable<Integer> vicini = grafo.getNeighbors(nodo);
		for(int vicino : vicini) {
			if(!scoperto[vicino]) {
				albero.addEdge(nodo, vicino);
				//System.out.println(vicino);
				visita(vicino);
			}else {
				//grafo con ciclo o indiretto
				exception=true;
			}
		}
	}
	//Ordine topologico. uso uno stack e applico la dfs
	//la funzione potrebbe essere fatta anche con arraylist anizche stack, ma in quel caso devo stampare la lista al contrario.
	public	ArrayList<Integer>	topologicalOrder(){
		scoperto = new boolean[grafo.getOrder()];
		topOrd = new Stack<Integer>();
		
		//controllo che visito tutti i nodi
		for(int i = 0; i< grafo.getOrder(); i++) {
			if(!scoperto[i])
				visita2(i);
		}
		System.out.println(exception);
		
		//stampo arrayList
		ArrayList<Integer> risultato = new ArrayList<Integer>();
		while (topOrd.empty()==false) {
			risultato.add(topOrd.pop());
		}
		System.out.println("stack:" +risultato);
		return risultato;
	}

	private void visita2(int nodo) {
		scoperto[nodo]=true;
		
		Iterable<Integer> vicini = grafo.getNeighbors(nodo);
		for(int vicino : vicini) {
			if(!scoperto[vicino]) {
				visita2(vicino);
			}
		}
		topOrd.push(nodo);
	}

}